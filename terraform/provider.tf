terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.8.0"
    }
  }

  backend "s3" {
    bucket = "bucket-of-keys20230714102552775100000001"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}


provider "aws" {
  region = "eu-west-2"
}