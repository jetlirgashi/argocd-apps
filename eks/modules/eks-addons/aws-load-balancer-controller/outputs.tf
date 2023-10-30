output "ingress_namespace" {
  value = local.helm_config["namespace"]
}

output "ingress_name" {
  value = local.helm_config["name"]
}