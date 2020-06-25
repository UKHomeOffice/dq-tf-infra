module "apps" {
  source = "github.com/UKHomeOffice/dq-tf-apps"

  providers = {
    aws = aws.APPS
  }

  cidr_block                      = "10.1.0.0/16"
  public_subnet_cidr_block        = "10.1.0.0/24"
  ad_subnet_cidr_block            = "10.1.16.0/24"
  haproxy_private_ip              = module.peering.haproxy_private_ip
  haproxy_private_ip2             = module.peering.haproxy_private_ip2
  az                              = "eu-west-2a"
  az2                             = "eu-west-2b"
  adminpassword                   = data.aws_kms_secrets.ad_admin_password.plaintext["ad_admin_password"]
  ad_aws_ssm_document_name        = module.ad.ad_aws_ssm_document_name
  ad_writer_instance_profile_name = module.ad.ad_writer_instance_profile_name
  naming_suffix                   = local.naming_suffix
  namespace                       = var.NAMESPACE
  s3_httpd_config_bucket          = module.ops.httpd_config_bucket
  s3_httpd_config_bucket_key      = module.ops.httpd_config_bucket_key
  haproxy_config_bucket           = module.peering.haproxy_config_bucket
  haproxy_config_bucket_key       = module.peering.haproxy_config_bucket_key

  s3_bucket_name = {
    archive_log                = "s3-dq-log-archive-bucket-${var.NAMESPACE}"
    archive_data               = "s3-dq-data-archive-bucket-${var.NAMESPACE}"
    working_data               = "s3-dq-data-working-bucket-${var.NAMESPACE}"
    landing_data               = "s3-dq-data-landing-bucket-${var.NAMESPACE}"
    airports_archive           = "s3-dq-airports-archive-${var.NAMESPACE}"
    airports_internal          = "s3-dq-airports-internal-${var.NAMESPACE}"
    airports_working           = "s3-dq-airports-working-${var.NAMESPACE}"
    oag_archive                = "s3-dq-oag-archive-${var.NAMESPACE}"
    oag_internal               = "s3-dq-oag-internal-${var.NAMESPACE}"
    oag_transform              = "s3-dq-oag-transform-${var.NAMESPACE}"
    acl_archive                = "s3-dq-acl-archive-${var.NAMESPACE}"
    acl_internal               = "s3-dq-acl-internal-${var.NAMESPACE}"
    reference_data_archive     = "s3-dq-reference-data-archive-${var.NAMESPACE}"
    reference_data_internal    = "s3-dq-reference-data-internal-${var.NAMESPACE}"
    consolidated_schedule      = "s3-dq-consolidated-schedule-${var.NAMESPACE}"
    api_archive                = "s3-dq-api-archive-${var.NAMESPACE}"
    cdl_pre_cutover            = "s3-dq-cdl-pre-cutover-${var.NAMESPACE}"
    api_internal               = "s3-dq-api-internal-${var.NAMESPACE}"
    api_record_level_scoring   = "s3-dq-api-record-level-scoring-${var.NAMESPACE}"
    gait_internal              = "s3-dq-gait-internal-${var.NAMESPACE}"
    cross_record_scored        = "s3-dq-cross-record-scored-${var.NAMESPACE}"
    reporting_internal_working = "s3-dq-reporting-internal-working-${var.NAMESPACE}"
    carrier_portal_working     = "s3-dq-carrier-portal-working-${var.NAMESPACE}"
    mds_extract                = "s3-dq-mds-extract-${var.NAMESPACE}"
    raw_file_index_internal    = "s3-dq-raw-file-index-internal-${var.NAMESPACE}"
    fms_working                = "s3-dq-fms-working-${var.NAMESPACE}"
    drt_working                = "s3-dq-drt-working-${var.NAMESPACE}"
    athena_log                 = "s3-dq-athena-log-${var.NAMESPACE}"
    freight_archive            = "s3-dq-freight-archive-${var.NAMESPACE}"
    bfid_virus_free_archive    = "s3-dq-bfid-virus-free-archive-${var.NAMESPACE}"
    bfid_virus_scan            = "s3-dq-bfid-virus-scan-${var.NAMESPACE}"
    bfid_virus_definitions     = "s3-dq-bfid-virus-definitions-${var.NAMESPACE}"
    nats_archive               = "s3-dq-nats-archive-${var.NAMESPACE}"
    nats_internal              = "s3-dq-nats-internal-${var.NAMESPACE}"
    cdlz_bitd_input            = "s3-dq-cdlz-bitd-input-${var.NAMESPACE}"
    api_arrivals               = "s3-dq-api-arrivals-${var.NAMESPACE}"
    accuracy_score             = "s3-dq-accuracy-score-${var.NAMESPACE}"
    api_cdlz_msk               = "s3-dq-api-cdlz-msk-${var.NAMESPACE}"
  }

  s3_bucket_acl = {
    archive_log                = "log-delivery-write"
    archive_data               = "private"
    working_data               = "private"
    landing_data               = "private"
    airports_archive           = "private"
    airports_internal          = "private"
    airports_working           = "private"
    oag_archive                = "private"
    oag_internal               = "private"
    oag_transform              = "private"
    acl_archive                = "private"
    acl_internal               = "private"
    reference_data_archive     = "private"
    reference_data_internal    = "private"
    consolidated_schedule      = "private"
    cdl_pre_cutover            = "private"
    api_archive                = "private"
    api_internal               = "private"
    api_record_level_scoring   = "private"
    gait_internal              = "private"
    cross_record_scored        = "private"
    reporting_internal_working = "private"
    carrier_portal_working     = "private"
    mds_extract                = "private"
    raw_file_index_internal    = "private"
    fms_working                = "private"
    drt_working                = "private"
    athena_log                 = "private"
    freight_archive            = "private"
    bfid_virus_free_archive    = "private"
    bfid_virus_scan            = "private"
    bfid_virus_definitions     = "private"
    nats_archive               = "private"
    nats_internal              = "private"
    cdlz_bitd_input            = "private"
    api_arrivals               = "private"
    accuracy_score             = "private"
  }

  vpc_peering_connection_ids = {
    peering_to_peering = aws_vpc_peering_connection.peering_to_apps.id
    peering_to_ops     = aws_vpc_peering_connection.apps_to_ops.id
  }

  route_table_cidr_blocks = {
    peering_cidr = module.peering.peeringvpc_cidr_block
    ops_cidr     = module.ops.opsvpc_cidr_block
  }

  ad_sg_cidr_ingress = [
    module.peering.peeringvpc_cidr_block,
    module.ops.opsvpc_cidr_block,
    module.ad.cidr_block,
    "10.1.0.0/16",
  ]
}
