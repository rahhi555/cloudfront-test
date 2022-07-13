variable "name" {}
variable "vpc_id" {}
variable "port" {}
variable "cidr_blocks" {
  # 文字列の配列型以外は弾く
  type = list(string)
}


# セキュリティーグループ
resource "aws_security_group" "default" {
  name = var.name
  vpc_id = var.vpc_id

  tags = {
    Name = var.name
  }
}

# インバウンドルール
resource "aws_security_group_rule" "ingress_home_care_navi_second" {
  type = "ingress"
  from_port = var.port
  to_port = var.port
  protocol = "tcp"
  cidr_blocks = var.cidr_blocks
  security_group_id = aws_security_group.default.id
}

# アウトバウンドルール
resource "aws_security_group_rule" "egress_home_care_navi_second" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.default.id
}

output "security_group_id" {
  value = aws_security_group.default.id
}