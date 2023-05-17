provider "aws" {
  region  = var.region
  profile = "default"
}

terraform {
  required_version = "~>1.4.5"
  backend "s3" {
    bucket  = "backend-carconnect-dev-tfstates"
    key     = "terraform/network.tfstate"
    region  = "us-east-1"
    profile = "default"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.57.0"
    }
  }
}