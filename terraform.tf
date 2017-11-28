terraform {
  backend "s3" {}
}

variable "CI_ID" {}
variable "CI_KEY" {}

provider "aws" {
  skip_credentials_validation = true
  region                      = "eu-west-2"
}

provider "aws" {
  alias                       = "CI"
  region                      = "eu-west-2"
  skip_credentials_validation = true
  access_key                  = "${var.CI_ID}"
  secret_key                  = "${var.CI_KEY}"
}

variable "MOCK_ID" {}
variable "MOCK_KEY" {}

provider "aws" {
  alias                       = "MOCK"
  region                      = "eu-west-2"
  skip_credentials_validation = true
  access_key                  = "${var.MOCK_ID}"
  secret_key                  = "${var.MOCK_KEY}"
}

variable "APPS_ID" {}
variable "APPS_KEY" {}

provider "aws" {
  alias                       = "APPS"
  region                      = "eu-west-2"
  skip_credentials_validation = true
  access_key                  = "${var.APPS_ID}"
  secret_key                  = "${var.APPS_KEY}"
}
