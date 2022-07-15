# ssl証明書のリクエスト
resource "aws_acm_certificate" "home_care_navi_second" {
  domain_name = "www.home-care-navi-second.work"
  # domain_nameとは別に追加したいドメイン名がある場合は記入する。なければ空配列。
  subject_alternative_names = []
  validation_method = "DNS"

  tags = {
    Name = "home_care_navi_second-acm"
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
    for dvo in aws_acm_certificate.home_care_navi_second.domain_validation_options : dvo.domain_name => {
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
  certificate_arn = aws_acm_certificate.home_care_navi_second.arn
  validation_record_fqdns = [ for record in aws_route53_record.home_care_navi_second_certificate : record.fqdn ]
}

