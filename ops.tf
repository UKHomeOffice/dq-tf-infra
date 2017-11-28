module "ops" {
  source = "github.com/ukhomeoffice/dq-tf-ops?ref=initial-ops"

  providers = {
    aws = "aws.APPS"
  }

  cidr_block            = "10.2.0.0/16"
  vpc_subnet_cidr_block = "10.2.1.0/24"
  az                    = "eu-west-2a"
  name_prefix           = "dq-"
}
