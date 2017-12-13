module "ops" {
  source = "github.com/UKHomeOffice/dq-tf-ops"

  providers = {
    aws = "aws.APPS"
  }

  cidr_block                = "10.2.0.0/16"
  vpc_subnet_cidr_block     = "10.2.0.0/24"
  az                        = "eu-west-2a"
  name_prefix               = "dq-"
  vpc_peering_to_peering_id = "1234"
  peering_to_acpvpn_id      = "1234"
  BDM_HTTPS_TCP             = "443"
  BDM_SSH_TCP               = "22"
  BDM_CUSTOM_TCP            = "5432"

  route_table_cidr_blocks = {
    peering_cidr = "${module.peering.peeringvpc_cidr_block}"
    apps_cidr    = "${module.apps.appsvpc_cidr_block}"
    acp_vpn      = "${module.mock-acp.acpvpn_cidr_block}"
    acp_prod     = "${module.mock-acp.acpprod_cidr_block}"
    acp_ops      = "${module.mock-acp.acpops_cidr_block}"
    acp_cicd     = "${module.mock-acp.acpcicd_cidr_block}"
  }
}

output "opsvpc_id" {
  value = "${module.ops.opsvpc_id}"
}

output "opsvpc_cidr_block" {
  value = "${module.ops.opsvpc_cidr_block}"
}

output "opssubnet_cidr_block" {
  value = "${module.ops.opssubnet_cidr_block}"
}
