module "peering" {
  source = "github.com/UKHomeOffice/dq-tf-peering"

  providers = {
    aws = aws.APPS
  }

  cidr_block                = "10.3.0.0/16"
  haproxy_subnet_cidr_block = "10.3.0.0/24"
  public_subnet_cidr_block  = "10.3.3.0/24"
  haproxy_private_ip        = "10.3.0.11"
  haproxy_private_ip2       = "10.3.0.12"
  s3_bucket_name            = "s3-dq-peering-haproxy-config-bucket-${var.NAMESPACE}"
  s3_bucket_acl             = "private"
  log_archive_s3_bucket     = module.apps.log_archive_bucket_id
  az                        = "eu-west-2a"
  naming_suffix             = local.naming_suffix
  namespace                 = var.NAMESPACE

  route_table_cidr_blocks = {
    ops_cidr  = module.ops.opsvpc_cidr_block
    apps_cidr = module.apps.appsvpc_cidr_block
    acp_prod  = data.aws_vpc_peering_connection.peering_to_acp.cidr_block
  }

  vpc_peering_connection_ids = {
    peering_and_apps    = aws_vpc_peering_connection.peering_to_apps.id
    peering_and_ops     = aws_vpc_peering_connection.peering_to_ops.id
    peering_and_acpprod = data.aws_vpc_peering_connection.peering_to_acp.id
  }

  SGCIDRs = [
    "10.3.0.0/16",
    module.apps.appsvpc_cidr_block,
    module.ops.opsvpc_cidr_block,
    data.aws_vpc_peering_connection.peering_to_acp.cidr_block,
  ]
}
