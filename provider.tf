terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 5.0"
    }
    rhcs = {
      source  = "terraform-redhat/rhcs"
      version = "1.6.5"
    }
  }
}

provider "aws" {
  access_key = var.aws_account_access_key
  secret_key = var.aws_account_secret_key
  region     = var.aws_region
}

provider "rhcs" {
  token = var.ocm_token
  url   = var.ocm_url
}
