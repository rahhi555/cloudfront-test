# ssl証明書のリクエスト(api)
resource "aws_acm_certificate" "home_care_navi_second_api" {
  domain_name = aws_route53_record.api.fqdn
  # domain_nameとは別に追加したいドメイン名がある場合は記入する。なければ空配列。
  subject_alternative_names = []
  validation_method = "DNS"

  tags = {
    Name = "home_care_navi_second_api-acm"
  }

  lifecycle {
    # 既存のリソースを削除してから新たなリソースを作成するのではなく、
    # 新たなリソースを作成してから既存のリソースを削除する。
    # こうすることでSSL証明書の再作成時のサービス影響を最小化する。
    create_before_destroy = true
  } 
}

# 検証用DNSレコード
resource "aws_route53_record" "home_care_navi_second_certificate" {
  for_each = {
    for dvo in aws_acm_certificate.home_care_navi_second_api.domain_validation_options : dvo.domain_name => {
      name = dvo.resource_record_name
      record = dvo.resource_record_value
      type = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name = each.value.name
  records = [each.value.record]
  ttl = 60
  type = each.value.type
  zone_id = aws_route53_zone.home_care_navi_second_route53_zone.zone_id
}

# 検証の待機
resource "aws_acm_certificate_validation" "home_care_navi_second" {
  certificate_arn = aws_acm_certificate.home_care_navi_second_api.arn
  validation_record_fqdns = [ for record in aws_route53_record.home_care_navi_second_certificate : record.fqdn ]
}

# ------------ cloudfront ------------

# cloudfrontは北部バージニアを指定してssl証明書を発行する。
# 参考：https://qiita.com/tos-miyake/items/f0e5f28f2a69e4d39422
provider "aws" {
  alias = "virginia"
  region = "us-east-1"
}

# ssl証明書のリクエスト(cloudfront)
resource "aws_acm_certificate" "home_care_navi_second_cloudfront" {
  domain_name = "www.home-care-navi-second.work"
  # domain_nameとは別に追加したいドメイン名がある場合は記入する。なければ空配列。
  subject_alternative_names = []
  validation_method = "DNS"
  provider = aws.virginia

  tags = {
    Name = "home_care_navi_second-cloudfront-acm"
  }

  lifecycle {
    # 既存のリソースを削除してから新たなリソースを作成するのではなく、
    # 新たなリソースを作成してから既存のリソースを削除する。
    # こうすることでSSL証明書の再作成時のサービス影響を最小化する。
    create_before_destroy = true
  } 
}

# 検証用DNSレコード
resource "aws_route53_record" "home_care_navi_second_cloudfront" {
  for_each = {
    for dvo in aws_acm_certificate.home_care_navi_second_cloudfront.domain_validation_options : dvo.domain_name => {
      name = dvo.resource_record_name
      record = dvo.resource_record_value
      type = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name = each.value.name
  records = [each.value.record]
  ttl = 60
  type = each.value.type
  zone_id = aws_route53_zone.home_care_navi_second_route53_zone.zone_id
}

# 検証の待機
resource "aws_acm_certificate_validation" "home_care_navi_second_cloudfront" {
  certificate_arn = aws_acm_certificate.home_care_navi_second_cloudfront.arn
  validation_record_fqdns = [ for record in aws_route53_record.home_care_navi_second_cloudfront : record.fqdn ]
  provider = aws.virginia
}