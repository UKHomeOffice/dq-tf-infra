module "mock-acp" {
  source = "github.com/ukhomeoffice/dq-tf-mock-acp"

  providers = {
    aws = "aws.MOCK"
  }

  acpcicd_cidr_block            = "10.7.0.0/16"
  acpcicd_vpc_subnet_cidr_block = "10.7.1.0/24"
  acpops_cidr_block             = "10.6.0.0/16"
  acpops_vpc_subnet_cidr_block  = "10.6.1.0/24"
  acpprod_cidr_block            = "10.5.0.0/16"
  acpprod_vpc_subnet_cidr_block = "10.5.1.0/24"
  acpvpn_cidr_block             = "10.4.0.0/16"
  acpvpn_vpc_subnet_cidr_block  = "10.4.1.0/24"
  az                            = "eu-west-2a"
  name_prefix                   = "dq-"
}
