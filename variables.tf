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
