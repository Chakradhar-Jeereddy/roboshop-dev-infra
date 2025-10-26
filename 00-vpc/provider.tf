terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.16.0"
    }
  }
  backend "s3" {
    bucket = "s3-chakra-27"
    region = "us-east-1"
    key = "terraform.state"
    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"
}