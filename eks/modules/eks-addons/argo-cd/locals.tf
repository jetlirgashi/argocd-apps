locals {

  default_helm_config = {
    name             = "argocd"
    repository       = "https://argoproj.github.io/argo-helm"
    chart            = "argo-cd"
    namespace        = "argo-cd"
    create_namespace = true
    version          = "5.48.1"
    values           = [file("${path.module}/values.yaml")]
    set              = []
    set_sensitive    = null
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )
}