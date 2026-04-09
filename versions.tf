terraform {
  required_version = ">= 0.13"
  required_providers {
    archive = {
      source = "hashicorp/archive"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.80.0"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}
