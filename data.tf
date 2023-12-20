data "aws_vpc_peering_connection" "ad_peering_with_ops" {
  provider      = aws.APPS
  vpc_id        = module.ops.opsvpc_id
  owner_id      = data.aws_caller_identity.apps.account_id
  peer_vpc_id   = module.ad.vpc_id
  peer_owner_id = data.aws_caller_identity.apps.account_id
}

data "aws_vpc_peering_connection" "ad_peering" {
  provider      = aws.APPS
  vpc_id        = module.apps.appsvpc_id
  owner_id      = data.aws_caller_identity.apps.account_id
  peer_vpc_id   = module.ad.vpc_id
  peer_owner_id = data.aws_caller_identity.apps.account_id
}

data "aws_vpc_peering_connection" "ops_to_acpvpn" {
  provider = aws.APPS

  tags = {
    Name = "ops-to-vpn"
  }
}

data "aws_vpc_peering_connection" "peering_to_acp" {
  provider = aws.APPS

  tags = {
    Name = "peering-to-acp"
  }
}

data "aws_caller_identity" "apps" {
  provider = aws.APPS
}

data "aws_caller_identity" "ci" {
  provider = aws.CI
}

resource "random_string" "AdminPassword" {
  length  = 16
  special = false
}

locals {
  AdminPassword = var.AdminPassword == false ? var.AdminPassword : random_string.AdminPassword.result
}

data "aws_kms_secrets" "ad_joiner_password" {
  secret {
    name    = "ad_joiner_password"
    payload = local.AdminPassword

    context = {
      terraform = "active_directory"
    }
  }
}

data "aws_kms_secrets" "ad_admin_password" {
  secret {
    name    = "ad_admin_password"
    payload = local.AdminPassword

    context = {
      terraform = "active_directory"
    }
  }
}
