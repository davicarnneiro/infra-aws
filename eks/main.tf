provider "aws" {
  region  = var.region
  profile = "default"
}

terraform {
  required_version = "~>1.4.5"
  backend "s3" {
    bucket  = "Minha Bucket S3"
    key     = "terraform/eks.tfstate"
    region  = "us-east-1"
    profile = "default"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.57.0"
    }
    spotinst = {
      source  = "spotinst/spotinst"
      version = "1.62.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.10.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.13.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.4.1"
    }
  }
}

provider "spotinst" {
  token   = var.spotinst_token
  account = var.spotinst_account
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}