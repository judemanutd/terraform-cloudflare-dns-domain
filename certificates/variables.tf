variable "domainName" {
  type = string
}

variable "alternateDomainNames" {
  type = list(string)
}

variable "zone_id" {
  type        = string
  description = "Cloudflare zone id"
}
