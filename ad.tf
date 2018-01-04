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

  subnets = [
    "${module.ops.ad_subnet_id}",
    "${module.apps.ad_subnet_id}",
  ]

  subnet_count = 2

  Domain = {
    address     = "dq.homeoffice.gov.uk"
    directoryOU = "OU=dqhomeoffice,DC=dq,DC=homeoffice,DC=gov,DC=uk"
  }
}

resource "aws_kms_key" "ad_joiner_account_key" {
  description             = "KMS key for AD Joiner account"
  deletion_window_in_days = 30

  policy = <<EOF
  {
  "Version": "2012-10-17",
  "Id": "key-default-1",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "${data.aws_caller_identity.ci.account_id}",
          "${data.aws_caller_identity.mocks.account_id}",
          "${data.aws_caller_identity.apps.account_id}"
        ]
      },
      "Action": "kms:*",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_kms_key" "ad_admin_account_key" {
  description             = "KMS key for AD admin account"
  deletion_window_in_days = 30

  policy = <<EOF
  {
  "Version": "2012-10-17",
  "Id": "key-default-1",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "${data.aws_caller_identity.ci.account_id}",
          "${data.aws_caller_identity.mocks.account_id}",
          "${data.aws_caller_identity.apps.account_id}"
        ]
      },
      "Action": "kms:*",
      "Resource": "*"
    }
  ]
}
EOF
}

output "AdminPassword" {
  value = "${module.ad.AdminPassword}"
}
