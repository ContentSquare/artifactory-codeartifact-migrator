terraform {
  backend "s3" {
    bucket         = "csq-rnd-mgmt-terraform"
    key            = "artifactory-migration/terraform.tfstate"
    region         = "eu-west-1"
    role_arn       = "arn:aws:iam::248230147984:role/terraform"
    session_name   = "Terraform"
    dynamodb_table = "terraform-lock-mgmt-eu-west-1"
  }
}

module "workspace_checker" {
  source       = "git@github.com:contentsquare/platform_terraform_modules.git//generic/workspace_checker?ref=7.28.0"
  project_name = var.project_name
  region       = var.region
  environment  = var.environment
}
