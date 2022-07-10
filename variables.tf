variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare token"
}

variable "aws_profile" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "site_domain" {
  type        = string
  description = "The domain name to use for the static site"
}
