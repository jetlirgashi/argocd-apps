variable "helm_config" {
  type        = any
  description = "Helm provider config for argo-cd."
  default     = {}
}

variable "host_name" {
  type        = string
  description = "Fully qualified domain name for argo cd"
}

variable "certificate_arn" {
  type        = string
  description = "Certificate arn for argod-cd"
}