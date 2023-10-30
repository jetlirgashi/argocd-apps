data "aws_eks_cluster" "cluster" {
  name = local.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = local.cluster_name
}

data "aws_caller_identity" "current" {}

data "aws_route53_zone" "hosted_zone" {
  name = "appstellar.training"
}

data "terraform_remote_state" "cluster" {
  backend = "remote"

  config = {
    organization = "devops-kubernetes-training"
    workspaces = {
      name = "eks-cluster"
    }
  }
}