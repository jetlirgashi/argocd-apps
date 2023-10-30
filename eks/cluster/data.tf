# data "terraform_remote_state" "iam" {
#   backend = "remote"

#   config = {
#     organization = "devops-kubernetes-training"
#     workspaces = {
#       name = "devops-training-group-6-iam"
#     }
#   }
# }

data "aws_caller_identity" "current" {}
