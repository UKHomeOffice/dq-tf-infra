data "aws_vpc_peering_connection" "ad_peering_with_ops" {
  provider      = "aws.APPS"
  vpc_id        = "${module.ops.opsvpc_id}"
  owner_id      = "${data.aws_caller_identity.apps.account_id}"
  peer_vpc_id   = "${module.ad.vpc_id}"
  peer_owner_id = "${data.aws_caller_identity.apps.account_id}"
}

data "aws_vpc_peering_connection" "ad_peering" {
  provider      = "aws.APPS"
  vpc_id        = "${module.apps.appsvpc_id}"
  owner_id      = "${data.aws_caller_identity.apps.account_id}"
  peer_vpc_id   = "${module.ad.vpc_id}"
  peer_owner_id = "${data.aws_caller_identity.apps.account_id}"
}

data "aws_caller_identity" "apps" {
  provider = "aws.APPS"
}

data "aws_caller_identity" "mocks" {
  provider = "aws.MOCK"
}

data "aws_caller_identity" "ci" {
  provider = "aws.CI"
}
