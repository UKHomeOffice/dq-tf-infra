resource "aws_iam_role" "cloudwatch_lambda_role" {
  name = "cloudwatch_lambda_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_to_cloudwatch_and_s3" {
  name   = "lambda_to_cloudwatch_and_s3"
  role   = "${aws_iam_role.cloudwatch_lambda_role.id}"
  policy = <<EOF
  {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Effect": "Allow",
              "Action": [
                  "logs:*"
              ],
              "Resource": "arn:aws:logs:*:*:*"
          },
          {
              "Effect": "Allow",
              "Action": [
                  "s3:GetObject",
                  "s3:PutObject"
              ],
              "Resource": "${module.apps.log_archive_bucket_arn}"
          }
      ]
  }
EOF
}

resource "aws_cloudwatch_event_rule" "every_24_hours" {
    name                = "every_24_hours"
    description         = "Runs every 24 hours."
    schedule_expression = "rate(24 hours)"
}

resource "aws_cloudwatch_event_target" "cloud_init" {
    rule = "${aws_cloudwatch_event_rule.every_24_hours.name}"
    arn  = "${aws_lambda_function.cloud_init_export.arn}"
}

resource "aws_cloudwatch_event_target" "cloud_init_output" {
    rule = "${aws_cloudwatch_event_rule.every_24_hours.name}"
    arn  = "${aws_lambda_function.cloud_init_output_export.arn}"
}

resource "aws_cloudwatch_event_target" "system" {
    rule = "${aws_cloudwatch_event_rule.every_24_hours.name}"
    arn  = "${aws_lambda_function.system_export.arn}"
}

resource "aws_lambda_function" "cloud_init_export" {
    filename      = "deployment.zip"
    function_name = "cloud_init_export_task"
    role          = "${aws_iam_role.cloudwatch_lambda_role.arn}"
    handler       = "cloud_init_export_task.lambda_handler"
    runtime       = "python3.6"
}

resource "aws_lambda_permission" "cloud_init" {
    statement_id   = "AllowExecutionFromCloudWatch"
    action         = "lambda:InvokeFunction"
    function_name  = "${aws_lambda_function.cloud_init_export.function_name}"
    principal      = "logs.amazonaws.com"
    source_arn     = "${aws_cloudwatch_event_rule.every_24_hours.arn}"
}

resource "aws_lambda_function" "cloud_init_output_export" {
    filename      = "deployment.zip"
    function_name = "cloud_init_output_export_task"
    role          = "${aws_iam_role.cloudwatch_lambda_role.arn}"
    handler       = "cloud_init_output_export_task.lambda_handler"
    runtime       = "python3.6"
}

resource "aws_lambda_permission" "cloud_init_output_export" {
    statement_id   = "AllowExecutionFromCloudWatch"
    action         = "lambda:InvokeFunction"
    function_name  = "${aws_lambda_function.cloud_init_output_export.function_name}"
    principal      = "logs.amazonaws.com"
    source_arn     = "${aws_cloudwatch_event_rule.every_24_hours.arn}"
}

resource "aws_lambda_function" "system_export" {
    filename      = "deployment.zip"
    function_name = "system_export_task"
    role          = "${aws_iam_role.cloudwatch_lambda_role.arn}"
    handler       = "system_export_task.lambda_handler"
    runtime       = "python3.6"
}

resource "aws_lambda_permission" "system" {
    statement_id   = "AllowExecutionFromCloudWatch"
    action         = "lambda:InvokeFunction"
    function_name  = "${aws_lambda_function.system_export.function_name}"
    principal      = "logs.amazonaws.com"
    source_arn     = "${aws_cloudwatch_event_rule.every_24_hours.arn}"
}
