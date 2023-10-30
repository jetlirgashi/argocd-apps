resource "kubernetes_ingress_v1" "argo_cd_ingress" {
  wait_for_load_balancer = true

  metadata {
    name      = "argo-cd"
    namespace = "argo-cd"

    annotations = {
      "kubernetes.io/ingress.class" : "alb"
      "alb.ingress.kubernetes.io/scheme" : "internet-facing"
      "alb.ingress.kubernetes.io/target-type" : "ip"
      "alb.ingress.kubernetes.io/certificate-arn" : "${var.certificate_arn}"
      "alb.ingress.kubernetes.io/tags" : "Name=argo-cd"
      "alb.ingress.kubernetes.io/group.name" : "argo-cd"
      "alb.ingress.kubernetes.io/listen-ports" : "[{\"HTTP\": 80}, {\"HTTPS\": 443}]"
      "alb.ingress.kubernetes.io/ssl-redirect" : "443"
    }
  }

  spec {
    rule {
      host = var.host_name
      http {
        path {
          path = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "argocd-server"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}