provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = {
      Terraform = true
    }
  }
}

provider "aws" {
  alias = "east"

  region  = "us-east-1"
  profile = var.aws_profile
}

resource "cloudflare_zone" "cf_zone" {
  zone = var.site_domain
}

module "cf_certificate" {
  source               = "./certificates"
  domainName           = "portal.${var.site_domain}"
  alternateDomainNames = ["www.portal.${var.site_domain}"]
  providers = {
    aws = aws.east
  }
  zone_id = cloudflare_zone.cf_zone.id
}
