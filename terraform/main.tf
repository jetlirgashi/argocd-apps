# module "ec2" {
#   source = "./modules/ec2"

#   instance_name = "my-first-instance"
#   subnet_id     = var.subnet_id
#   instance_type = var.instance_type
# }

module "iam" {
  source    = "./modules/iam"
  user_name = var.user_name
}

