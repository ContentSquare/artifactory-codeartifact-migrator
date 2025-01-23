module "falco_editions_iam_role" {
  source              = "git@github.com:contentsquare/platform_terraform_modules.git//aws/iam_role_eks?ref=9.4.0"
  project_name        = "${local.falco_project_name}-editions-${var.project_name}"
  environment         = var.environment
  region              = var.region
  k8s_namespace       = local.falco_project_name
  k8s_service_account = "${local.falco_project_name}-editions-shared-service-account"
  k8s_cluster         = data.aws_eks_cluster.eks_cluster
  providers = {
    aws = aws.mgmt
  }
}

resource "aws_iam_role_policy" "code_artifact" {

  name = var.project_name
  role = module.iam_role.this_iam_role

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          Action : [
            "codeartifact:*"
          ],
          Resource : [
            "*"
          ],
          Effect : "Allow"
        },
      ]
    }
  )
}

module "finder" {
  source           = "git@github.com:contentsquare/platform_terraform_modules.git//aws/k8s_finder?ref=9.1.0"
  environment      = "dev"
  override_cluster = "eks-pavard-dev-eu-west-1"
}
