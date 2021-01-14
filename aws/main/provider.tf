terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"

    }
  }

  backend "remote" {
    organization = "nkjcorp"

    workspaces {
      name = "aws-cli-driven"
    }
  }

  credentials "app.terraform.io"{
  value = "Yusj4UqR1NHBMw.atlasv1.rvXxkeQqnTOzWfGvvto7TQH3k2mIpCWmtimXPJQrJDHlRG73gwykKisq9tHxj3GrxS4"
  }
}

provider "aws" {
  region = "ap-south-1" // Mumbai region
  access_key = var.access_key
  secret_key = var.secret_key
}