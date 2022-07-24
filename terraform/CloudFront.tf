# 複数登場するので変数を定義する
locals {
  s3_origin_id = "home-care-navi-second-cloudfront-terraform.s3.ap-northeast-1.amazonaws.com"
}

resource "aws_cloudfront_distribution" "home_care_navi_second_distribution" {
  origin {
    domain_name = local.s3_origin_id
    origin_id = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/E4Q9UG4N6VFED"
    }
  }

  restrictions {
    geo_restriction {
      locations = []
      restriction_type = "none"
    }
  }

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    target_origin_id = local.s3_origin_id
    allowed_methods = ["GET", "HEAD"]
    cached_methods = ["GET", "HEAD"]
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    compress = true
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.home_care_navi_second_cloudfront.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method = "sni-only"
  }

  custom_error_response {
    error_code = 403
    error_caching_min_ttl = 300
    response_code = 200
    response_page_path = "/index.html"
  }

  enabled = true
  is_ipv6_enabled = true
  default_root_object = "index.html"
  aliases = [ "www.home-care-navi-second.work" ]

}
