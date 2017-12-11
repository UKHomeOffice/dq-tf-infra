module "peering" {
  source = "github.com/ukhomeoffice/dq-tf-peering"

  providers = {
    aws = "aws.APPS"
  }

  cidr_block                            = "10.3.0.0/16"
  haproxy_subnet_cidr_block             = "10.3.0.0/24"
  connectivity_tester_subnet_cidr_block = "10.3.2.0/24"
  peering_connectivity_tester_ip        = "10.3.2.11"
  az                                    = "eu-west-2a"
  name_prefix                           = "dq-"

  SGCIDRs = [
    "10.3.0.0/16",
    "${module.apps.appsvpc_cidr_block}",
    "${module.ops.opsvpc_cidr_block}",
    "${module.mock-acp.acpvpn_cidr_block}",
    "${module.mock-acp.acpprod_cidr_block}",
    "${module.mock-acp.acpops_cidr_block}",
    "${module.mock-acp.acpcicd_cidr_block}",
  ]
}

output "peeringvpc_id" {
  value = "${module.peering.peeringvpc_id}"
}
