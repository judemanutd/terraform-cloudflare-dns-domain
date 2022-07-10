resource "aws_acm_certificate" "cert" {
  domain_name               = var.domainName
  subject_alternative_names = var.alternateDomainNames
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Terraform = true
  }
}

resource "cloudflare_record" "cf_record" {
  for_each = {
    for item in aws_acm_certificate.cert.domain_validation_options : item.domain_name => {
      name   = item.resource_record_name
      record = item.resource_record_value
      type   = item.resource_record_type
    }
  }

  zone_id         = var.zone_id
  allow_overwrite = true
  proxied         = true
  name            = each.value.name
  type            = each.value.type
  value           = each.value.record
  ttl             = 1
}

# resource "aws_acm_certificate_validation" "cf_validation" {
#   certificate_arn         = aws_acm_certificate.cert.arn
#   validation_record_fqdns = [for record in cloudflare_record.cf_record : record.hostname]
# }
