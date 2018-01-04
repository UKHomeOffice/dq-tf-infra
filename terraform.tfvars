terragrunt = {
  remote_state {
    backend = "s3"
    config {
      bucket = "dq-tf-infra-terraform-state"
      region = "eu-west-2"
      dynamodb_table = "terraform-state"
      key = "${get_env("TF_VAR_NAMESPACE", "notprod")}/terraform.tfstate"
      encrypt = true
    }
  }
}
