module "peering" {
  source = "github.com/ukhomeoffice/dq-tf-peering"

  providers = {
    aws = "aws.APPS"
  }

  cidr_block                     = "10.3.0.0/16"
  haproxy_subnet_cidr_block      = "10.3.0.0/24"
  connectivity_tester_subnet     = "10.3.2.0/24"
  peering_connectivity_tester_ip = "10.3.2.11"
  az                             = "eu-west-2a"
  name_prefix                    = "dq-"

  SGCIDRs = [
    "10.1.0.0/16",
    "10.2.0.0/16",
    "10.3.0.0/16",
    "10.4.0.0/16",
    "10.5.0.0/16",
    "10.6.0.0/16",
    "10.7.0.0/16",
  ]
}

output "peeringvpc_id" {
  value = "${module.peering.appsvpc_id}"
}
