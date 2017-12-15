module "ad" {
  providers = {
    aws = "aws.APPS"
  }
  source       = "github.com/ukhomeoffice/dq-tf-ad"
//  source       = "../dq-tf-ad"
  peer_with    = [
    "${module.ops.opsvpc_id}",
    "${module.apps.appsvpc_id}",
  ]
  peer_count   = 2
  subnets      = [
//    "${module.apps.appssubnet_cidr_block}",
    "10.2.0.0/16",
    "10.1.10.0/24",
  ]
  subnet_count = 0
  Domain       = {
    address     = "dq.homeoffice.gov.uk"
    directoryOU = "OU=dqhomeoffice,DC=dqhomeoffice,DC=gov.uk"
  }
}