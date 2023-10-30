resource "helm_release" "argo_cd" {
  name             = local.helm_config["name"]
  repository       = local.helm_config["repository"]
  chart            = local.helm_config["chart"]
  version          = local.helm_config["version"]
  namespace        = local.helm_config["namespace"]
  create_namespace = local.helm_config["create_namespace"]
  values           = local.helm_config["values"]

  dynamic "set" {
    iterator = each_item
    for_each = local.helm_config["set"] == null ? [] : local.helm_config["set"]

    content {
      name  = each_item.value.name
      value = each_item.value.value
    }
  }

  dynamic "set_sensitive" {
    iterator = each_item
    for_each = local.helm_config["set_sensitive"] == null ? [] : local.helm_config["set_sensitive"]

    content {
      name  = each_item.value.name
      value = each_item.value.value
    }
  }
}
