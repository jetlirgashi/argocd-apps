terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "devops-kubernetes-training"

    workspaces {
      name = "eks-cluster"
    }
  }
}