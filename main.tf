locals {
  naming_suffix  = "${var.NAMESPACE}-dq"
  iam_role_count = length(module.apps.iam_roles)
}

provider "aws" {
  alias      = "CI"
  region     = "eu-west-2"
  access_key = var.CI_ID
  secret_key = var.CI_KEY
}

provider "aws" {
  alias      = "ENV_ACCT"
  region     = "eu-west-2"
  access_key = var.ENV_ACCT_ID
  secret_key = var.ENV_ACCT_KEY
}
