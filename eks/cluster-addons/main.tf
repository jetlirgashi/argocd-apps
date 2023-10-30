locals {

  aws_region   = "eu-central-1"
  cluster_name = "eks-cluster"
  vpc_id       = data.terraform_remote_state.cluster.outputs.vpc_id
  account_id   = data.aws_caller_identity.current.account_id

  eks_managed_node_groups = data.terraform_remote_state.cluster.outputs.eks_managed_node_groups

  node_iam_role_arns = distinct(
    compact([for group in local.eks_managed_node_groups : group.iam_role_arn])
  )

  node_iam_roles = distinct(
    compact([for group in local.eks_managed_node_groups : group.iam_role_name])
  )

  iam_users = [
    "mehmetali-shaqiri",
    "aceshko",
    "dg3ntrit",
    "sokolavdyli",
    "jetlir.gashi",
    "patriot.murati",
    "arditzubaku",
    "arianitjahaj",
    "muhamed.fazliu",
    "vildanasllani",
    "doniz",
    "ecinci",
    "easanii",
    "gezimkastrati",
    "mirandosmani",
    "hadisajeti",
  ]


  mapRoles = yamlencode(concat(
    [for role_arn in local.node_iam_role_arns : {
      rolearn  = role_arn
      username = "system:node:{{EC2PrivateDNSName}}"
      groups = [
        "system:bootstrappers",
        "system:nodes",
      ]
      }
    ]
  ))

  mapUsers = yamlencode(concat([for user in local.iam_users :
    {
      userarn  = "arn:aws:iam::${local.account_id}:user/${user}"
      username = "${user}"
      groups   = ["system:masters"]
    }
  ]))

  aws_auth_configmap_data = {
    mapRoles = local.mapRoles
    mapUsers = local.mapUsers
  }

  default_tags = {

  }
}

module "eks_addons" {
  source         = "../modules/eks-addons"
  eks_cluster_id = local.cluster_name
  node_iam_roles = local.node_iam_roles

  enable_aws_load_balancer_controller = true
  aws_load_balancer_controller_helm_config = {
    values = [templatefile("${path.module}/helm-config/aws-load-balancer-controller-values.yaml", {
      eks_cluster_id       = "${local.cluster_name}"
      vpc_id               = "${local.vpc_id}"
      aws_region           = "${local.aws_region}"
      service_account_name = "aws-load-balancer-controller"
    })]
  }

  enable_argo_cd          = true
  argo_cd_host_name       = "argocd.appstellar.training"
  argo_cd_certificate_arn = aws_acm_certificate.cert.arn

  tags = local.default_tags
}