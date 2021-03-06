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
      name = "kubernetes"
    }
  }
}

provider "aws" {
  region = "ap-south-1"  //Mumbai
  access_key = var.access_key
  secret_key = var.secret_key
}