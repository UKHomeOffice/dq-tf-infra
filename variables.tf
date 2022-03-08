#AWS credentials
variable "CI_ID" {
}

variable "CI_KEY" {
}

variable "APPS_ID" {
}

variable "APPS_KEY" {
}

variable "NAMESPACE" {
  default = "notprod"
}

variable "DOMAIN_JOINER_PWD" {
}

variable "account_id" {
  type = map(string)
  default = {
    "test"    = "797728447925"
    "notprod" = "483846886818"
    "prod"    = "337779336338"
  }
}

variable "dq_ips_notprod" {
  type = list(string)
  default = [
    "35.177.179.157/32",
    "35.177.132.243/32",
    "35.177.100.236/32"
  ]
}

variable "dq_ips_prod" {
  type = list(string)
  default = [
    "52.56.43.118/32",
    "35.177.168.246/32",
    "35.177.128.206/32"
  ]
}
