terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5"
    }
  }
  required_version = "~> 1.2"
}


module "tags" {
  source       = "git@github.com:contentsquare/platform_terraform_modules.git//generic/tags?ref=7.22.2"
  environment  = var.environment
  github_repo  = "some"
  owners       = var.owners
  product      = var.product
  project_name = var.project_name
}

module "accounts" {
  source       = "git@github.com:contentsquare/platform_terraform_modules.git//aws/accounts?ref=8.1.4"
  environment  = var.environment
  region       = var.region
  old_accounts = true
}

provider "aws" {
  region = var.region
  assume_role {
    role_arn     = module.accounts.tf_role
    session_name = "Terraform"
  }
}
