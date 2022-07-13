# DBのセキュリティーグループ
module "postgres_sg" {
  source = "./security_group"
  name = "postgres-sg"
  vpc_id = aws_vpc.home_care_navi_second.id
  # DB側のportと合わせる
  port = 5432
  # vpc内のみでの通信のため、インバウンドルールのcidr_blockはvpcのものを指定する
  cidr_blocks = [aws_vpc.home_care_navi_second.cidr_block]
}

# DBパラメータグループの定義
resource "aws_db_parameter_group" "home_care_navi_second" {
  name = "home-care-navi-second"
  family = "postgres14"

  parameter {
    name = "client_encoding"
    value = "UTF8"
  }

  parameter {
    name = "timezone"
    value = "Asia/Tokyo"
  }
}

# DBサブネットグループの定義
resource "aws_db_subnet_group" "home_care_navi_second" {
  name = "home_care_navi_second"
  # サブネット最低２つ必要。なのでvpc.tfであらかじめ２つは作っておくこと
  subnet_ids = [aws_subnet.private.id, aws_subnet.private_other.id]
}

resource "aws_db_instance" "home_care_navi_second" {
  # データベースの識別子
  identifier = "home-care-navi-second"
  engine = "postgres"
  engine_version = "14.2"
  instance_class = "db.t3.micro"
  # 最大ストレージ容量。最低は20Gib
  allocated_storage = 20
  # allocated_storageの容量がオーバーした時に自動的にスケールする容量
  max_allocated_storage = 100
  storage_type = "gp2"
  # 暗号化
  storage_encrypted = true
  # 暗号化に使用する鍵。自分で作成したKMSの鍵を使って暗号化する。
  kms_key_id = aws_kms_key.home_care_navi_second.arn
  username = "postgres"
  # 初期状態のパスワード。DB起動後すぐに変更する。
  password = "postgres"
  # マルチAZを有効にする(サブネットグループの定義で異なるAZのサブネットを指定することが前提)
  multi_az = false
  # VPC外からのアクセスを許可する
  publicly_accessible = false
  # 自動的にDBをアップグレードするか。
  auto_minor_version_upgrade = false
  # 削除する際にスナップショットを作成しない
  skip_final_snapshot = true
  port = 5432
  vpc_security_group_ids = [module.postgres_sg.security_group_id]
  parameter_group_name = aws_db_parameter_group.home_care_navi_second.name
  db_subnet_group_name = aws_db_subnet_group.home_care_navi_second.name

  # 手動でパスワードを変更した後、terraform applyしてもソースコードのパスワードに戻らないようにする
  lifecycle {
    ignore_changes = [password]
  }
}