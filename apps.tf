module "apps" {
  source = "github.com/UKHomeOffice/dq-tf-apps"

  providers = {
    aws = "aws.APPS"
  }

  cidr_block               = "10.1.0.0/16"
  public_subnet_cidr_block = "10.1.0.0/24"
  az                       = "eu-west-2a"
  name_prefix              = "dq-"

  vpc_peering_connection_ids = {
    peering_to_peering = "${aws_vpc_peering_connection.peering_to_apps.id}"
    peering_to_ops     = "${aws_vpc_peering_connection.apps_to_ops.id}"
  }

  route_table_cidr_blocks = {
    peering_cidr = "${module.peering.peeringvpc_cidr_block}"
    ops_cidr     = "${module.ops.opsvpc_cidr_block}"
    acp_vpn      = "${module.mock-acp.acpvpn_cidr_block}"
    acp_prod     = "${module.mock-acp.acpprod_cidr_block}"
    acp_ops      = "${module.mock-acp.acpops_cidr_block}"
    acp_cicd     = "${module.mock-acp.acpcicd_cidr_block}"
    ad_cidr      = "${module.ad.cidr_block}"
  }
}

output "appsvpc_id" {
  value = "${module.apps.appsvpc_id}"
}

output "appsvpc_cidr_block" {
  value = "${module.apps.appsvpc_cidr_block}"
}
