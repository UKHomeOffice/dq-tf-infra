resource "aws_iam_policy" "write_to_cw" {
  name     = "dq-tf-infra-write_to_cw"
  provider = aws.APPS

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "cloudwatch:PutMetricData",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"
      ],
        "Resource": [
          "arn:aws:logs:*:*:*"
      ]
    },
    {
        "Effect": "Allow",
        "Action": "ec2:DescribeTags",
        "Resource": "*"
    },
    {
      "Sid": "DomainJoinPolicy",
      "Effect": "Allow",
      "Action": [
          "ssm:DescribeAssociation",
          "ssm:ListAssociations",
          "ssm:GetDocument",
          "ssm:ListInstanceAssociations",
          "ssm:UpdateAssociationStatus",
          "ssm:UpdateInstanceAssociationStatus",
          "ssm:UpdateInstanceInformation",
          "ec2messages:AcknowledgeMessage",
          "ec2messages:DeleteMessage",
          "ec2messages:FailMessage",
          "ec2messages:GetEndpoint",
          "ec2messages:GetMessages",
          "ec2messages:SendReply",
          "ds:CreateComputer",
          "ds:DescribeDirectories",
          "ec2:DescribeInstanceStatus"
      ],
      "Resource": [
          "*"
      ]
    }
  ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "write_to_cw" {
  role = element(
    concat(
      module.apps.iam_roles,
      module.ops.iam_roles,
      module.peering.iam_roles,
    ),
    count.index,
  )
  policy_arn = aws_iam_policy.write_to_cw[0].arn
  count      = 20
}
