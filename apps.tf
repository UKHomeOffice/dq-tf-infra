module "apps" {
  source = "github.com/UKHomeOffice/dq-tf-apps"

  providers = {
    aws = "aws.APPS"
  }

  cidr_block                = "10.1.0.0/16"
  public_subnet_cidr_block  = "10.1.0.0/24"
  az                        = "eu-west-2a"
  name_prefix               = "dq-"
  vpc_peering_to_peering_id = "${aws_vpc_peering_connection.peering_to_apps.id}"
  vpc_peering_to_ops_id     = "${aws_vpc_peering_connection.apps_to_ops.id}"

  route_table_cidr_blocks = {
    peering_cidr = "${module.peering.peeringvpc_cidr_block}"
    ops_cidr     = "${module.ops.opsvpc_cidr_block}"
    acp_vpn      = "${module.mock-acp.acpvpn_cidr_block}"
    acp_prod     = "${module.mock-acp.acpprod_cidr_block}"
    acp_ops      = "${module.mock-acp.acpops_cidr_block}"
    acp_cicd     = "${module.mock-acp.acpcicd_cidr_block}"
  }
}

output "appsvpc_id" {
  value = "${module.apps.appsvpc_id}"
}

output "appsvpc_cidr_block" {
  value = "${module.apps.appsvpc_cidr_block}"
}

output "bdm_db_server_ip_address" {
  value = "${module.apps.bdm_db_server_ip_address}"
}
