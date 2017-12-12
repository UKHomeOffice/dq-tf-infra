module "peering_to_apps" {
  source = "github.com/UKHomeOffice/tf-peering"

  providers = {
    aws.source = "aws.APPS"
    aws.dest   = "aws.APPS"
  }

  vpc_source_vpc_id = "${module.peering.peeringvpc_id}"
  vpc_dest_vpc_id   = "${module.apps.appsvpc_id}"
}

output "peering_and_apps_peering_id" {
  value = "${module.peering_to_apps.peering_id}"
}
