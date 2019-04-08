module "ops" {
  source = "github.com/UKHomeOffice/dq-tf-ops"

  providers = {
    aws = "aws.APPS"
  }

  naming_suffix                   = "${local.naming_suffix}"
  cidr_block                      = "${var.NAMESPACE == "prod" ? "10.2" : "10.8"}.0.0/16"
  vpc_subnet_cidr_block           = "${var.NAMESPACE == "prod" ? "10.2" : "10.8"}.0.0/24"
  public_subnet_cidr_block        = "${var.NAMESPACE == "prod" ? "10.2" : "10.8"}.2.0/24"
  ad_subnet_cidr_block            = "${var.NAMESPACE == "prod" ? "10.2" : "10.8"}.4.0/24"
  az                              = "eu-west-2a"
  bastion_linux_ip                = "${var.NAMESPACE == "prod" ? "10.2" : "10.8"}.0.11"
  bastion_windows_ip              = "${var.NAMESPACE == "prod" ? "10.2" : "10.8"}.0.12"
  bastion2_windows_ip             = "${var.NAMESPACE == "prod" ? "10.2" : "10.8"}.0.13"
  bastion3_windows_ip             = "${var.NAMESPACE == "prod" ? "10.2" : "10.8"}.0.14"
  bastion4_windows_ip             = "${var.NAMESPACE == "prod" ? "10.2" : "10.8"}.0.15"
  bastion5_windows_ip             = "${var.NAMESPACE == "prod" ? "10.2" : "10.8"}.0.16"
  management_access               = "${var.NAMESPACE == "prod" ? "10.2" : "10.8"}.0.11/32"
  analysis_instance_ip            = "${var.NAMESPACE == "prod" ? "10.2" : "10.8"}.2.8"
  ad_aws_ssm_document_name        = "${module.ad.ad_aws_ssm_document_name}"
  ad_writer_instance_profile_name = "${module.ad.ad_writer_instance_profile_name}"
  adminpassword                   = "${data.aws_kms_secrets.ad_admin_password.plaintext["ad_admin_password"]}"
  log_archive_s3_bucket           = "${module.apps.log_archive_bucket_id}"
  s3_bucket_name                  = "s3-dq-httpd-config-bucket-${var.NAMESPACE}"
  athena_log_bucket               = "${module.apps.athena_log_bucket}"
  aws_bucket_key                  = "${module.apps.aws_bucket_key}"

  vpc_peering_connection_ids = {
    ops_and_apps    = "${aws_vpc_peering_connection.apps_to_ops.id}"
    ops_and_peering = "${aws_vpc_peering_connection.peering_to_ops.id}"
    ops_and_acpvpn  = "${data.aws_vpc_peering_connection.ops_to_acpvpn.id}"
  }

  route_table_cidr_blocks = {
    peering_cidr = "${module.peering.peeringvpc_cidr_block}"
    apps_cidr    = "${module.apps.appsvpc_cidr_block}"
    acp_vpn      = "${data.aws_vpc_peering_connection.ops_to_acpvpn.cidr_block}"
  }

  ad_sg_cidr_ingress = [
    "${module.peering.peeringvpc_cidr_block}",
    "${module.apps.appsvpc_cidr_block}",
    "${module.ad.cidr_block}",
    "${var.NAMESPACE == "prod" ? "10.2" : "10.8"}.0.0/16",
  ]
}
