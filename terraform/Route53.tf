resource "aws_route53_zone" "home_care_navi_second_route53_zone" {
  name = "home-care-navi-second.work"
}

# http及びhttps用のドメイン紐付け
resource "aws_route53_record" "http_https" {
  zone_id = aws_route53_zone.home_care_navi_second_route53_zone.zone_id
  name = "www"
  type = "A"

  alias {
    name = aws_lb.home_care_navi_second.dns_name
    zone_id = aws_lb.home_care_navi_second.zone_id
    evaluate_target_health = false
  }
}

output "route53_http" {
  value = aws_route53_record.http_https.name
}