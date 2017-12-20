module "ops" {
  source = "github.com/UKHomeOffice/dq-tf-ops"

  providers = {
    aws = "aws.APPS"
  }

  cidr_block                      = "10.2.0.0/16"
  vpc_subnet_cidr_block           = "10.2.0.0/24"
  public_subnet_cidr_block        = "10.2.2.0/24"
  ad_subnet_cidr_block            = "10.2.4.0/24"
  az                              = "eu-west-2a"
  name_prefix                     = "dq-"
  bastion_linux_ip                = "10.2.0.11"
  bastion_windows_ip              = "10.2.0.12"
  BDM_HTTPS_TCP                   = "443"
  BDM_SSH_TCP                     = "22"
  BDM_CUSTOM_TCP                  = "5432"
  INT_EXT_TABLEAU_RDP_TCP         = "3389"
  INT_EXT_TABLEAU_HTTPS_TCP       = "443"
  data_pipeline_RDP_TCP           = "3389"
  data_pipeline_custom_TCP        = "1433"
  data_ingest_RDP_TCP             = "3389"
  data_ingest_custom_TCP          = "5432"
  external_feed_RDP_TCP           = "3389"
  external_feed_custom_TCP        = "5432"
  greenplum_ip                    = "10.1.2.11"
  BDM_RDS_db_instance_ip          = "${module.apps.bdm_db_server_ip_address}"
  ad_aws_ssm_document_name        = "${module.ad.ad_aws_ssm_document_name}"
  ad_writer_instance_profile_name = "${module.ad.ad_writer_instance_profile_name}"

  vpc_peering_connection_ids = {
    ops_and_apps    = "${aws_vpc_peering_connection.apps_to_ops.id}"
    ops_and_peering = "${aws_vpc_peering_connection.peering_to_ops.id}"
    ops_and_acpvpn  = "${module.ops_to_acpvpn.peering_id}"
    peering_to_ad   = "${data.aws_vpc_peering_connection.ad_peering_with_ops.id}"
  }

  route_table_cidr_blocks = {
    peering_cidr = "${module.peering.peeringvpc_cidr_block}"
    apps_cidr    = "${module.apps.appsvpc_cidr_block}"
    acp_vpn      = "${module.mock-acp.acpvpn_cidr_block}"
    acp_prod     = "${module.mock-acp.acpprod_cidr_block}"
    acp_ops      = "${module.mock-acp.acpops_cidr_block}"
    acp_cicd     = "${module.mock-acp.acpcicd_cidr_block}"
    ad_cidr      = "${module.ad.cidr_block}"
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
