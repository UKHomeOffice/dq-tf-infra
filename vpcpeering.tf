locals {
  vpc_peering_naming_suffix = "vpc-peering-${local.naming_suffix}"
}

resource "aws_vpc_peering_connection" "peering_to_apps" {
  provider      = aws.ENV_ACCT
  vpc_id        = module.peering.peeringvpc_id
  peer_vpc_id   = module.apps.appsvpc_id
  peer_owner_id = data.aws_caller_identity.apps.account_id
  auto_accept   = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = {
    Name = "peering-to-apps-${local.vpc_peering_naming_suffix}"
  }
}

resource "aws_vpc_peering_connection" "peering_to_ops" {
  provider      = aws.ENV_ACCT
  vpc_id        = module.peering.peeringvpc_id
  peer_vpc_id   = module.ops.opsvpc_id
  peer_owner_id = data.aws_caller_identity.apps.account_id
  auto_accept   = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = {
    Name = "peering-to-ops-${local.vpc_peering_naming_suffix}"
  }
}

resource "aws_vpc_peering_connection" "apps_to_ops" {
  provider      = aws.ENV_ACCT
  vpc_id        = module.apps.appsvpc_id
  peer_vpc_id   = module.ops.opsvpc_id
  peer_owner_id = data.aws_caller_identity.apps.account_id
  auto_accept   = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = {
    Name = "apps-to-ops-${local.vpc_peering_naming_suffix}"
  }
}
