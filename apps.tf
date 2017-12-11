module "apps" {
  source = "github.com/ukhomeoffice/dq-tf-apps"

  providers = {
    aws = "aws.APPS"
  }

  cidr_block               = "10.1.0.0/16"
  public_subnet_cidr_block = "10.1.0.0/24"
  az                       = "eu-west-2a"
  name_prefix              = "dq-"
}

output "appsvpc_id" {
  value = "${module.apps.appsvpc_id}"
}

output "appsvpc_cidr_block" {
  value = "${module.apps.appsvpc_cidr_block}"
}
