locals {
  service_account_name = "aws-load-balancer-controller-sa"

  default_helm_config = {
    name             = "aws-load-balancer-controller"
    chart            = "aws-load-balancer-controller"
    repository       = "https://aws.github.io/eks-charts"
    version          = "1.6.1"
    namespace        = "kube-system"
    timeout          = "1200"
    create_namespace = false
    values           = local.default_helm_values
    set              = []
    set_sensitive    = null
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  default_helm_values = [templatefile("${path.module}/values.yaml", {
    aws_region           = data.aws_region.current.name,
    eks_cluster_id       = var.eks_cluster_id,
    service_account_name = local.service_account_name
  })]
}