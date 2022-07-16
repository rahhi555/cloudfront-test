resource "aws_route53_zone" "home_care_navi_second_route53_zone" {
  name = "home-care-navi-second.work"
}

# api用のドメイン紐付け
resource "aws_route53_record" "api" {
  zone_id = aws_route53_zone.home_care_navi_second_route53_zone.zone_id
  name = "api"
  type = "A"

  alias {
    name = aws_lb.home_care_navi_second.dns_name
    zone_id = aws_lb.home_care_navi_second.zone_id
    evaluate_target_health = false
  }
}

output "route53_http" {
  value = aws_route53_record.api.name
}

# ----- cloudfront -----

# cloudfront用のドメイン紐付け
resource "aws_route53_record" "cloudfront" {
  zone_id = aws_route53_zone.home_care_navi_second_route53_zone.zone_id
  name = "www"
  type = "A"

  alias {
    name = aws_cloudfront_distribution.home_care_navi_second_distribution.domain_name
    zone_id = aws_cloudfront_distribution.home_care_navi_second_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}