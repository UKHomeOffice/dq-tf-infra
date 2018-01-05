module "apps" {
  source = "github.com/UKHomeOffice/dq-tf-apps"

  providers = {
    aws = "aws.APPS"
  }

  cidr_block                      = "10.1.0.0/16"
  public_subnet_cidr_block        = "10.1.0.0/24"
  ad_subnet_cidr_block            = "10.1.16.0/24"
  az                              = "eu-west-2a"
  name_prefix                     = "dq-"
  adminpassword                   = "${module.ad.AdminPassword}"
  ad_aws_ssm_document_name        = "${module.ad.ad_aws_ssm_document_name}"
  ad_writer_instance_profile_name = "${module.ad.ad_writer_instance_profile_name}"

  s3_bucket_name = {
    archive_log  = "s3-dq-log-archive-bucket-preprod"
    archive_data = "s3-dq-data-archive-bucket-preprod"
    working_data = "s3-dq-data-working-bucket-preprod"
    landing_data = "s3-dq-data-landing-bucket-preprod"
  }

  s3_bucket_acl = {
    archive_log  = "log-delivery-write"
    archive_data = "private"
    working_data = "private"
    landing_data = "private"
  }

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
  }

  ad_sg_cidr_ingress = [
    "${module.peering.peeringvpc_cidr_block}",
    "${module.ops.opsvpc_cidr_block}",
    "${module.ad.cidr_block}",
    "10.1.0.0/16",
  ]
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
