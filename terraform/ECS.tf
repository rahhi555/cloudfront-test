# apiのサービスに割り当てるRDS用のセキュリティーグループ
module "api_sg" {
  source = "./security_group"
  name   = "api-sg"
  vpc_id = aws_vpc.home_care_navi_second.id
  port   = 5432
  # vpc内のみでの通信のため、インバウンドルールのcidr_blockはvpcのものを指定する
  cidr_blocks = [aws_vpc.home_care_navi_second.cidr_block]
}

# 上記のセキュリティーグループにfront用のインバウンドルール追加
resource "aws_security_group_rule" "ingress_home_care_navi_second_api_front" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.home_care_navi_second.cidr_block]
  security_group_id = module.api_sg.security_group_id
}

# ECSタスク実行IAMロールを取得し、ECRの操作権限を付与できるようにする
# AmazonECSTaskExecutionRolePolicyの取得
data "aws_iam_policy" "ecs_task_execution_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ECSタスク実行IAMロールのポリシードキュメントの定義
data "aws_iam_policy_document" "ecs_task_execution" {
  # ポリシーの継承することができる
  source_policy_documents = [
    data.aws_iam_policy.ecs_task_execution_role_policy.policy
  ]
  statement {
    effect = "Allow"
    # ssm及びsecrets managerで登録したパラメータをECSの環境変数として取得できる権限。s3のファイルを取得する権限(.envファイル取得に使用する)
    actions   = ["ssm:GetParameters", "kms:Decrypt", "secretsmanager:GetSecretValue", "s3:GetObject", "s3:GetBucketLocation"]
    resources = ["*"]
  }
}

# ECSタスク実行IAMロールの定義 これをタスク定義のexecution_role_arn(タスク実行IAMロール)に記入
module "ecs_task_execution_role" {
  source     = "./iam_role"
  name       = "ecs-task-execution"
  identifier = "ecs-tasks.amazonaws.com"
  policy     = data.aws_iam_policy_document.ecs_task_execution.json
}

#　タスクロール。ecs execをするためのaction4つを追加。
module "ecs_for_exec" {
  source     = "./iam_role"
  name       = "ecs-for-exec"
  identifier = "ecs-tasks.amazonaws.com"
  policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Sid    = ""
          Effect = "Allow"
          Action = [
            "ssmmessages:CreateControlChannel",
            "ssmmessages:CreateDataChannel",
            "ssmmessages:OpenControlChannel",
            "ssmmessages:OpenDataChannel",
          ],
          Resource = "*"
        }
      ]
    }
  )
}

# ECSクラスター
resource "aws_ecs_cluster" "home_care_navi_second" {
  name = "home_care_navi_second"
}

# ECSタスク定義 api
resource "aws_ecs_task_definition" "home_care_navi_second_api" {
  family = "home_care_navi_second_api"
  cpu = "256"
  memory = "512"
  network_mode = "awsvpc"
  requires_compatibilities = [ "FARGATE" ]
  # ECS ExecをするためのIAMロール
  task_role_arn = module.ecs_for_exec.iam_role_arn
  # CloudWacthにログを投げるためのタスク実行時IAMロール
  execution_role_arn = module.ecs_task_execution_role.iam_role_arn
  # コンテナ定義
  container_definitions = file("./container_definitions/api.json")
}

# ECSサービス api
resource "aws_ecs_service" "home_care_navi_second_api" {
  name = "home_care_navi_second_service_api"
  cluster = aws_ecs_cluster.home_care_navi_second.arn
  task_definition = aws_ecs_task_definition.home_care_navi_second_api.arn
  desired_count = 1
  launch_type = "FARGATE"
  # FARGATEを選択したときのみ適用される。デフォルトは"LATEST"。
  platform_version = "1.4.0"
  # ECS Execを有効にする
  enable_execute_command = true

  # awsvpcネットワークモードの際に必要になるオプション。
  network_configuration {
    # パブリックIPを割り当てるか。下のsubnetsでパブリックサブネットを割り当てるならtrueにする。
    # プライベートサブネットを割り当てるならfalseでいいが、その場合ecrからコンテナを引っ張ってくるため
    # NAT gateway 等のエンドポイントが必要になる。
    assign_public_ip = true
    security_groups = [ module.api_sg.security_group_id ]
    subnets = [ 
      aws_subnet.public.id,
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.home_care_navi_second_api.arn
    # コンテナ定義で設定したコンテナの名前
    container_name = "home_care_navi_second_api"
    container_port = 3000
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}