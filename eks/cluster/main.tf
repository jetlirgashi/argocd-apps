locals {
  region       = "eu-central-1"
  cluster_name = "eks-cluster"

  default_tags = {
    Project = "devops-kubernetes-training"
    Environment = "dev"
  }
}

module "aws_eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "v19.17.2"

  manage_aws_auth_configmap = false
  
  # External encryption key
  create_kms_key = false
  
  cluster_encryption_config = {
    resources        = ["secrets"]
    provider_key_arn = module.kms.key_arn
  }

  cluster_name    = local.cluster_name
  cluster_version = "1.28"

  # NETWORK CONFIG
  vpc_id  = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true


  cloudwatch_log_group_retention_in_days  = 5

  # IRSA
  enable_irsa = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 2
      desired_size = 1

      instance_types = ["t3.medium"]
      capacity_type  = "SPOT"
      labels = {
        Training = "devops"
      }

      update_config = {
        max_unavailable_percentage = 50 # or set `max_unavailable`
      }


      tags = {
        Training = "devops"
      }
    }
    nodegroup2 = {
      min_size     = 1
      max_size     = 2
      desired_size = 1

      instance_types = ["t3.small"]
      capacity_type  = "SPOT"
      labels = {
        Training = "devops"
      }

      update_config = {
        max_unavailable_percentage = 50 # or set `max_unavailable`
      }


      tags = {
        Training = "devops"
      }
    }
  }

  # CLUSTER LOGGING
  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  tags = local.default_tags
}

module "kms" {
  source  = "terraform-aws-modules/kms/aws"
  version = "~> 1.5"

  aliases               = ["eks/${local.cluster_name}"]
  description           = "${local.cluster_name} cluster encryption key"
  enable_default_policy = true
  key_owners            = [data.aws_caller_identity.current.arn]

  tags = local.default_tags
}