data "aws_caller_identity" "source" {
  provider = "aws.APPS"
}

data "aws_caller_identity" "dest" {
  provider = "aws.MOCK"
}

module "peering_to_apps" {
  source = "github.com/UKHomeOffice/tf-peering"

  providers = {
    source = "aws.source"
    dest   = "aws.source"
  }

  vpc_source_vpc_id = "${module.peering.peeringvpc_id}"
  vpc_dest_vpc_id   = "${module.apps.appsvpc_id}"
}

output "peering_and_apps_peering_id" {
  value = "${module.peering_to_apps.peering_id}"
}
