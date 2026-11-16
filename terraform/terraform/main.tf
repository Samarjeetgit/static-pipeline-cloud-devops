# Create production isolation boundary namespace
resource "kubernetes_namespace" "prod" {
  metadata {
    name = "production"
    labels = {
      environment = "production"
      security    = "zero-trust"
    }
  }
}

# Apply Resource Quota to enforce strict limits
resource "kubernetes_resource_quota" "prod_quota" {
  metadata {
    name      = "env-resource-quota"
    namespace = kubernetes_namespace.prod.metadata[0].name
  }
  spec {
    hard = {
      "requests.cpu"    = "1"
      "requests.memory" = "1Gi"
      "limits.cpu"      = "2"
      "limits.memory"   = "2Gi"
      "pods"            = "10"
    }
  }
}
