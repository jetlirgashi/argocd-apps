variable "eks_cluster_id" {
  description = "EKS Cluster Id"
}

variable "eks_oidc_issuer_url" {
  description = "The URL on the EKS cluster OIDC Issuer"
  default     = ""
}

variable "eks_oidc_provider_arn" {
  description = "The ARN of the OIDC Provider if `enable_irsa = true`."
  default     = ""
}

variable "enable_aws_load_balancer_controller" {
  type        = bool
  default     = false
  description = "Enable AWS Load Balancer Controller add-on"
}

variable "aws_load_balancer_controller_helm_config" {
  type        = any
  description = "AWS Load Balancer Controller Helm Chart config"
  default     = {}
}

variable "node_iam_roles" {
  type        = list(string)
  description = "List of node group iam roles"
}


variable "enable_kubernetes_dashboard" {
  type        = bool
  default     = false
  description = "Enable Kuberneted Dashboard add-on"
}

variable "kubernetes_dashboard_helm_config" {
  description = "Kuberneted Dashboard Helm Chart config"
  type        = any
  default     = {}
}

variable "enable_argo_cd" {
  type        = bool
  default     = false
  description = "Enable ArgoCD add-on"
}

variable "argo_cd_helm_config" {
  description = "ArgoCD Helm Chart config"
  type        = any
  default     = {}
}

variable "argo_cd_host_name" {
  type        = string
  description = "Fully qualified domain name for argo cd"
}

variable "argo_cd_certificate_arn" {
  type        = string
  description = "Certificate arn for argod-cd"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}