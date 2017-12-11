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

output "acpopsvpc_id" {
  value = "${module.mock-acp.acpopsvpc_id}"
}

output "acpops_cidr_block" {
  value = "${module.mock-acp.acpops_cidr_block}"
}

output "acpcicdvpc_id" {
  value = "${module.mock-acp.acpcicdvpc_id}"
}

output "acpcicd_cidr_block" {
  value = "${module.mock-acp.acpcicd_cidr_block}"
}

output "acpprodvpc_id" {
  value = "${module.mock-acp.acpprodvpc_id}"
}

output "acpprod_cidr_block" {
  value = "${module.mock-acp.acpprod_cidr_block}"
}

output "acpvpnvpc_id" {
  value = "${module.mock-acp.acpvpnvpc_id}"
}

output "acpvpn_cidr_block" {
  value = "${module.mock-acp.acpvpn_cidr_block}"
}
