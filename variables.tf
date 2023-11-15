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
}

variable "AdminPassword" {
}
