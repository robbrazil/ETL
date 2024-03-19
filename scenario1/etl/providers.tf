terraform {
  required_version = "= 1.6.6"

  backend "s3" {
    bucket         = ""
    key            = ""
    region         = ""
    encrypt        = ""
    dynamodb_table = ""
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}
