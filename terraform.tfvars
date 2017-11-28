terragrunt = {
  remote_state {
    backend = "s3"
    config {
      bucket = "dq-tf-infra-terraform-state"
      region = "eu-west-2"
      dynamodb_table = "terraform-state"
      key = "${path_relative_to_include()}/terraform.tfstate"
      encrypt = true
    }
  }
}
