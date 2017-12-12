resource "aws_vpc_peering_connection" "peering_to_apps" {
  provider      = "aws.APPS"
  vpc_id        = "${module.peering.peeringvpc_id}"
  peer_vpc_id   = "${module.apps.appsvpc_id}"
  peer_owner_id = "${data.aws_caller_identity.source.account_id}"
  auto_accept   = true
}
