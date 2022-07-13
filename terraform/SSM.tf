# railsのマスターキー
resource "aws_ssm_parameter" "rails_master_key" {
  name = "/api/rails-master-key"
  value = "master-key"
  type = "SecureString"
  description = "railsのマスターキー"

  lifecycle {
    ignore_changes = [value]
  }
}