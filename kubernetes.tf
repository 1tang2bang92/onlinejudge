resource "kind_cluster" "default" {
  name           = "onlinejudge"
  wait_for_ready = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"

      kubeadm_config_patches = [
        "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
      ]

      extra_port_mappings {
        container_port = 5432
        host_port      = 5432
      }
    }

    node {
      role = "worker"
      labels = {
        "env"  = "dev"
        "name" = "dev-worker"
      }
    }

    node {
      role = "worker"
      labels = {
        "env"  = "product"
        "name" = "product-worker"
      }
    }
  }
}
