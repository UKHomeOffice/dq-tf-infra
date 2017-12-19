module "ad" {
  providers = {
    aws = "aws.APPS"
  }

  source = "github.com/ukhomeoffice/dq-tf-ad"

  peer_with = [
    "${module.ops.opsvpc_id}",
    "${module.apps.appsvpc_id}",
  ]

  cidr_block                      = "10.99.0.0/16"
  allow_remote_vpc_dns_resolution = false
  peer_count                      = 2

  subnets = []

  //        "${module.apps.appssubnet_cidr_block}",
  //    "10.2.0.0/24",
  //
  //    "10.1.10.0/24",

  subnet_count = 2
  Domain = {
    address     = "dq.homeoffice.gov.uk"
    directoryOU = "OU=dqhomeoffice,DC=dqhomeoffice,DC=gov.uk"
  }
}

output "AD Admin Password" {
  value = "${module.ad.AdminPassword}"
}
