resource "helm_release" "lb_ingress" {
  name       = local.helm_config["name"]
  repository = local.helm_config["repository"]
  chart      = local.helm_config["chart"]
  version    = local.helm_config["version"]
  namespace  = local.helm_config["namespace"]
  values     = local.helm_config["values"]

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

resource "aws_iam_policy" "aws_load_balancer_controller" {
  name        = "${var.eks_cluster_id}-lb-controller-policy"
  description = "Allows lb controller to manage ALB and NLB"
  policy      = data.aws_iam_policy_document.aws_lb.json
}

resource "aws_iam_role_policy_attachment" "load_balancer" {
  for_each   = toset(var.node_iam_roles)
  policy_arn = aws_iam_policy.aws_load_balancer_controller.arn
  role       = each.value
}