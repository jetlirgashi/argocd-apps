module "aws_load_balancer_controller" {
  count                 = var.enable_aws_load_balancer_controller ? 1 : 0
  source                = "./aws-load-balancer-controller"
  helm_config           = var.aws_load_balancer_controller_helm_config
  eks_cluster_id        = var.eks_cluster_id
  eks_oidc_issuer_url   = var.eks_oidc_issuer_url
  eks_oidc_provider_arn = var.eks_oidc_provider_arn
  node_iam_roles        = var.node_iam_roles
  tags                  = var.tags
}

module "argo_cd" {
  count           = var.enable_argo_cd ? 1 : 0
  source          = "./argo-cd"
  helm_config     = var.argo_cd_helm_config
  host_name       = var.argo_cd_host_name
  certificate_arn = var.argo_cd_certificate_arn
}