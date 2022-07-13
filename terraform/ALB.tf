# api用セキュリティーグループ
module "https_api_sg" {
  source = "./security_group"
  name = "https-api-sg"
  vpc_id = aws_vpc.home_care_navi_second.id
  port = 3000
  cidr_blocks = ["0.0.0.0/0"]
}

# アプリケーションロードバランサー
resource "aws_lb" "home_care_navi_second" {
  name = "home-care-navi-second"
  load_balancer_type = "application"
  # インターネット向けか内部向けか。falseならインターネット向け。
  internal = false
  idle_timeout = 60
  # trueの場合、ロードバランサーの削除はAWSAPIを介して無効になります。
  # これにより、Terraformがロードバランサーを削除できなくなります。
  # enable_deletion_protection = true

  subnets = [ 
    aws_subnet.public.id,
    aws_subnet.public_other.id,
  ]

  access_logs {
    bucket = aws_s3_bucket.alb_log.id
    enabled = true
  }

  security_groups = [ 
    module.https_api_sg.security_group_id
  ]
}

output "alb_dns_name" {
  value = aws_lb.home_care_navi_second.dns_name
}

###############    apiのリスナー及びターゲットグループの設定    ################

# albのapi用リスナー(frontをhttpsにしているので、api側もhttpsにしないとmixed contentエラーが発生する)
resource "aws_lb_listener" "api" {
  load_balancer_arn = aws_lb.home_care_navi_second.arn
  port = "3000"
  protocol = "HTTPS"
  certificate_arn = aws_acm_certificate.home_care_navi_second.arn
  ssl_policy = "ELBSecurityPolicy-2016-08"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "これはHTTPSかつapiです"
      status_code = "200"
    }
  }
}

# ターゲットグループ(api)
resource "aws_lb_target_group" "home_care_navi_second_api" {
  name = "home-care-navi-second-api"
  target_type = "ip"
  vpc_id = aws_vpc.home_care_navi_second.id
  port = 3000
  protocol = "HTTP"
  deregistration_delay = 300

  health_check {
    path = "/health-check"
    # 正常のしきい値 この回数分連続でヘルスチェックに成功すれば正常とみなされる
    healthy_threshold = 5
    # 非正常のしきい値　この回数分連続でヘルスチェックに失敗すると異常とみなされる
    unhealthy_threshold = 5
    timeout = 20
    interval = 30
    # 成功したときのレスポンスコード
    matcher = 200
    # ヘルスチェックで使用されるポート。traffic-portにした場合、指定されているポートになる(3000)。
    port = "traffic-port"
    protocol = "HTTP"
  }
  # 依存関係を明示する
  depends_on = [aws_lb.home_care_navi_second]
  
  tags = {
    Name = "home_care_navi_second-alb-api-target"
  }
}

# ターゲットグループにリクエストをフォワードするリスナールール(api)
resource "aws_lb_listener_rule" "home_care_navi_second_api" {
  listener_arn = aws_lb_listener.api.arn
  priority = 98

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.home_care_navi_second_api.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}
