module "acpcicd" {
  source = "github.com/ukhomeoffice/dq-tf-mock-acp?ref=acpcicd"

  providers = {
    aws = "aws.APPS"
  }

  cidr_block            = "10.1.0.0/16"
  vpc_subnet_cidr_block = "10.1.1.0/24"
  az                    = "eu-west-2a"
  name_prefix           = "dq-"
}
