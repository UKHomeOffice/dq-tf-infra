module "apps" {
  source = "github.com/ukhomeoffice/dq-tf-apps"

  providers = {
    aws = "aws.APPS"
  }

  cidr_block                  = "10.1.0.0/16"
  public_subnet_cidr_block    = "10.1.0.0/24"
  dqdb_apps_cidr_block        = "10.1.2.0/24"
  ext_feed_apps_cidr_block    = "10.1.4.0/24"
  data_ingest_apps_cidr_block = "10.1.6.0/24"
  data_pipe_apps_cidr_block   = "10.1.8.0/24"
  mdm_apps_cidr_block         = "10.1.10.0/24"
  int_dashboard_cidr_block    = "10.1.12.0/24"
  ext_dashboard_cidr_block    = "10.1.14.0/24"
  az                          = "eu-west-2a"
  name_prefix                 = "dq-"
}
