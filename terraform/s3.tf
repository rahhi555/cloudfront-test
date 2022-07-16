# プライベートバケット
resource "aws_s3_bucket" "private" {
  bucket = "home-care-navi-second-private-terraform"
  force_destroy = true
}

# プライベートバケットのアクセス制限
resource "aws_s3_bucket_public_access_block" "private" {
  bucket = aws_s3_bucket.private.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

#　alb(アプリケーションロードバランサー)ログバケット
resource "aws_s3_bucket" "alb_log" {
  bucket = "home-care-navi-second-alb-log-terraform"
  force_destroy = true
}

# acl設定
resource "aws_s3_bucket_acl" "alb_log" {
  bucket = aws_s3_bucket.alb_log.id
  acl = "private"
}

# ログバケットの破棄周期
resource "aws_s3_bucket_lifecycle_configuration" "alb_log" {
  bucket = aws_s3_bucket.alb_log.id

  rule {
    id = "rule_alb_log"
    expiration {
      days = 7
    }
    status = "Enabled"
  }
}

# alb_logバケットポリシーに使用するポリシードキュメント
data "aws_iam_policy_document" "alb_log" {
  statement {
    effect = "Allow"
    actions = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.alb_log.id}/*"]

    principals {
      type = "AWS"
      # ここのIDはリージョンによって決まる。詳しくは下のURL
      # https://docs.aws.amazon.com/ja_jp/elasticloadbalancing/latest/classic/enable-access-logs.html
      identifiers = ["582318560864"]
    }
  }
}
# alb_logバケットポリシー
resource "aws_s3_bucket_policy" "alb_log" {
  bucket = aws_s3_bucket.alb_log.id
  policy = data.aws_iam_policy_document.alb_log.json
}

# ----- cloudfront -----

# cloudfrontバケット
resource "aws_s3_bucket" "cloudfront" {
  bucket = "home-care-navi-second-cloudfront-terraform"
}

# cloudfrontバケットのアクセス制限
resource "aws_s3_bucket_public_access_block" "cloudfront" {
  bucket = aws_s3_bucket.cloudfront.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}