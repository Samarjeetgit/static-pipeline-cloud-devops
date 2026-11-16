resource "kubernetes_deployment" "app" {
  metadata {
    name      = "core-api-service"
    namespace = kubernetes_namespace.prod.metadata[0].name
    labels = {
      app = "core-api"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "core-api"
      }
    }

    template {
      metadata {
        labels = {
          app = "core-api"
        }
      }

      spec {
        security_context {
          run_as_non_root = true
          run_as_user     = 10001
        }

        container {
          image = "nginx:alpine-slim"
          name  = "api-server"

          port {
            container_port = 8080
          }

          resources {
            limits = {
              cpu    = "200m"
              memory = "256Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "128Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/healthz"
              port = 8080
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }

          readiness_probe {
            http_get {
              path = "/healthz"
              port = 8080
            }
            initial_delay_seconds = 3
            period_seconds        = 5
          }
        }
      }
    }
  }
}
