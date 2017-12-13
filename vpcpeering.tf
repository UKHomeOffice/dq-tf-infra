data "aws_caller_identity" "apps" {
  provider = "aws.APPS"
}

resource "aws_vpc_peering_connection" "peering_to_apps" {
  provider      = "aws.APPS"
  vpc_id        = "${module.peering.peeringvpc_id}"
  peer_vpc_id   = "${module.apps.appsvpc_id}"
  peer_owner_id = "${data.aws_caller_identity.apps.account_id}"
  auto_accept   = true

  tags {
    Name = "Peering and Apps"
  }
}

resource "aws_vpc_peering_connection" "peering_to_ops" {
  provider      = "aws.APPS"
  vpc_id        = "${module.peering.peeringvpc_id}"
  peer_vpc_id   = "${module.ops.opsvpc_id}"
  peer_owner_id = "${data.aws_caller_identity.apps.account_id}"
  auto_accept   = true

  tags {
    Name = "Peering and Ops"
  }
}

resource "aws_vpc_peering_connection" "apps_to_ops" {
  provider      = "aws.APPS"
  vpc_id        = "${module.apps.appsvpc_id}"
  peer_vpc_id   = "${module.ops.opsvpc_id}"
  peer_owner_id = "${data.aws_caller_identity.apps.account_id}"
  auto_accept   = true

  tags {
    Name = "Apps and Ops"
  }
}

module "peering_to_acpprod" {
  source = "github.com/UKHomeOffice/tf-peering"

  providers = {
    aws.source = "aws.APPS"
    aws.dest   = "aws.MOCK"
  }

  vpc_source_vpc_id = "${module.peering.peeringvpc_id}"
  vpc_dest_vpc_id   = "${module.mock-acp.acpprodvpc_id}"
}

module "peering_to_acpcicd" {
  source = "github.com/UKHomeOffice/tf-peering"

  providers = {
    aws.source = "aws.APPS"
    aws.dest   = "aws.MOCK"
  }

  vpc_source_vpc_id = "${module.peering.peeringvpc_id}"
  vpc_dest_vpc_id   = "${module.mock-acp.acpcicdvpc_id}"
}

module "peering_to_acpops" {
  source = "github.com/UKHomeOffice/tf-peering"

  providers = {
    aws.source = "aws.APPS"
    aws.dest   = "aws.MOCK"
  }

  vpc_source_vpc_id = "${module.peering.peeringvpc_id}"
  vpc_dest_vpc_id   = "${module.mock-acp.acpopsvpc_id}"
}

module "ops_to_acpvpn" {
  source = "github.com/UKHomeOffice/tf-peering"

  providers = {
    aws.source = "aws.APPS"
    aws.dest   = "aws.MOCK"
  }

  vpc_source_vpc_id = "${module.ops.opsvpc_id}"
  vpc_dest_vpc_id   = "${module.mock-acp.acpvpnvpc_id}"
}
