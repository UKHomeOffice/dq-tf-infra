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

  route_table_cidr_blocks = {
    ops_cidr  = "${module.ops.opsvpc_cidr_block}"
    apps_cidr = "${module.apps.appsvpc_cidr_block}"
    acp_vpn   = "${module.mock-acp.acpvpn_cidr_block}"
    acp_prod  = "${module.mock-acp.acpprod_cidr_block}"
    acp_ops   = "${module.mock-acp.acpops_cidr_block}"
    acp_cicd  = "${module.mock-acp.acpcicd_cidr_block}"
  }

  vpc_peering_connection_ids = {
    peering_and_apps    = "${aws_vpc_peering_connection.peering_to_apps.id}"
    peering_and_ops     = "${aws_vpc_peering_connection.peering_to_ops.id}"
    peering_and_acpprod = "${module.peering_to_acpprod.peering_id}"
    peering_and_acpops  = "${module.peering_to_acpops.peering_id}"
    peering_and_acpcicd = "${module.peering_to_acpcicd.peering_id}"
    peering_and_acpvpn  = "${module.peering_to_acpvpn.peering_id}"
  }

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
