data "aws_vpc_peering_connection" "ad_peering_with_ops" {
  provider      = aws.ENV_ACCT
  vpc_id        = module.ops.opsvpc_id
  owner_id      = data.aws_caller_identity.apps.account_id
  peer_vpc_id   = module.ad.vpc_id
  peer_owner_id = data.aws_caller_identity.apps.account_id
}

data "aws_vpc_peering_connection" "ad_peering" {
  provider      = aws.ENV_ACCT
  vpc_id        = module.apps.appsvpc_id
  owner_id      = data.aws_caller_identity.apps.account_id
  peer_vpc_id   = module.ad.vpc_id
  peer_owner_id = data.aws_caller_identity.apps.account_id
}

data "aws_vpc_peering_connection" "ops_to_acpvpn" {
  provider = aws.ENV_ACCT

  tags = {
    Name = "ops-to-vpn"
  }
}

data "aws_vpc_peering_connection" "peering_to_acp" {
  provider = aws.ENV_ACCT

  tags = {
    Name = "peering-to-acp"
  }
}

data "aws_caller_identity" "apps" {
  provider = aws.ENV_ACCT
}

data "aws_caller_identity" "ci" {
  provider = aws.CI
}
