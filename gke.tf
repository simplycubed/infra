data "google_client_config" "default" {}



module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  project_id                 = var.project_id
  name                       = var.gke_cluster_name
  region                     = var.region
  network                    = module.vpc.network_name
  subnetwork                 = module.vpc.subnets_names[0]
  ip_range_pods              = module.vpc.subnets_secondary_ranges[0][0].range_name
  ip_range_services          = module.vpc.subnets_secondary_ranges[0][1].range_name
  release_channel            = "STABLE"
  http_load_balancing        = true
  horizontal_pod_autoscaling = false
  regional                   = var.regional_gke_cluster
  network_policy             = true
  enable_private_nodes       = true
  grant_registry_access      = true
  zones                       = var.zones
  istio                      = var.istio_enabled
  istio_auth                 = "AUTH_NONE"
  # istio_auth                 = "AUTH_MUTUAL_TLS"
  remove_default_node_pool   = true
  node_pools = [
    {
      name            = "default-node-pool"
      machine_type    = var.gke_machine_type
      local_ssd_count = 0
      disk_size_gb    = 100
      autoscaling     = false
      disk_type       = "pd-standard"
      image_type      = "COS"
      auto_repair     = true
      auto_upgrade    = true
      preemptible     = false
      node_count      = var.gke_initial_node_count
      node_locations  = "${var.region}-a,${var.region}-b"
    },
  ]
  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append"
    ]
  }
  depends_on = [
    module.vpc,
    google_compute_ssl_policy.tls
  ]
}



resource "google_compute_ssl_policy" "tls" {
  name            = "ssl-policy"
  min_tls_version = "TLS_1_2"
}


module "workload_identity" {
  source     = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  project_id = var.project_id
  name       = "iden-${module.gke.name}"
  namespace  = "default"
  roles = [
    "roles/storage.admin",
    "roles/cloudsql.client"
  ]
  use_existing_k8s_sa = false
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "prometheus-operator"
    labels = {
      istio-injection = "enabled"
    }
  }
}

resource "kubernetes_namespace" "argo" {
  metadata {
    name = "argo"
    # labels = {
    #   istio-injection = "enabled"
    # }
  }
}

resource "kubernetes_namespace" "source_graph" {
  metadata {
    name = "source-graph"
  }
}

resource "kubernetes_namespace" "builder" {
  metadata {
    name = "builder"
    # labels = {
    #   istio-injection = "enabled"
    # }
  }
}

resource "kubernetes_secret" "iap_k8s_secret_istio_system" {
  metadata {
    name      = "iap-secrets"
    namespace = "istio-system"
  }
  data = {
    "client_secret" : google_iap_client.iap_client.secret
    "client_id" : google_iap_client.iap_client.client_id
  }
}

# resource "kubernetes_secret" "iap_k8s_secret_sourcegraph" {
#   metadata {
#     name      = "iap-secrets"
#     namespace = "sourcegraph"
#   }
#   data = {
#     "client_secret" : google_iap_client.iap_client.secret
#     "client_id" : google_iap_client.iap_client.client_id
#   }
# }

# resource "kubernetes_secret" "site_config_sourcegraph_secret" {
#   metadata {
#     name      = "site-config-sourcegraph"
#     namespace = "sourcegraph"
#   }
#   data = {
#     "site-config.json" : <<EOF
#     {
#       "externalURL": "https://source-graph.${var.base_domain}",
#      	"auth.providers": [
#          {
#            "type": "openidconnect",
#            "issuer": "https://accounts.google.com",
#            "clientID": "${var.source_graph_client_id}",
#            "clientSecret": "${var.source_graph_client_secret}",
#            "requireEmailDomain": "simplycubed.com"
#          }
#      	],
     
#      	"search.index.enabled": true
#      }
  
#   EOF
#   }
# }

resource "kubernetes_secret" "repo_ssh_key" {
  metadata {
    name      = "repo-ssh-key"
    namespace = kubernetes_namespace.argo.id
  }
  data = {
    "sshPrivateKey" : var.env_repo_ssh_key
  }
}

resource "helm_release" "prometheus_operator" {
  count     = var.prometheus_enabled?1:0
  name      = "prometheus-operator"
  chart     = "helm/prometheus-operator"
  namespace = kubernetes_namespace.monitoring.id
  values = [
    file("./helm/prometheus-operator/values.yaml")
  ]
  set {
    name  = "prometheusLocal.ingressIstio.annotations.kubernetes\\.io/ingress\\.global-static-ip-name"
    value = google_compute_global_address.global_address[0].name
  }
  set {
    name  = "prometheusLocal.ingressIstio.hosts"
    value = "{${join(",", ["prometheus.${var.base_domain}"])}}"
  }
  set {
    name  = "alertmanagerLocal.ingressIstio.annotations.kubernetes\\.io/ingress\\.global-static-ip-name"
    value = google_compute_global_address.global_address[2].name
  }
  set {
    name  = "alertmanagerLocal.ingressIstio.hosts"
    value = "{${join(",", ["alert-manager.${var.base_domain}"])}}"
  }
  set {
    name  = "grafanaLocal.ingressIstio.annotations.kubernetes\\.io/ingress\\.global-static-ip-name"
    value = google_compute_global_address.global_address[1].name
  }
  set {
    name  = "grafanaLocal.ingressIstio.hosts"
    value = "{${join(",", ["grafana.${var.base_domain}"])}}"
  }
  set {
    name  = "prometheus-operator.grafana.grafana\\.ini.auth\\.google.client_id"
    value = var.grafana_oauth_client_id
  }

  set {
    name  = "prometheus-operator.grafana.grafana\\.ini.auth\\.google.client_secret"
    value = var.grafana_oauth_client_secret
  }
  set {
    name  = "prometheus-operator.grafana.grafana\\.ini.server.root_url"
    value = "https://grafana.${var.base_domain}"
  }
}


resource "helm_release" "argo_cd" {
  name      = "argo-cd"
  chart     = "./helm/argo-cd"
  namespace = kubernetes_namespace.argo.id
  values = [
    file("helm/argo-cd/values.yaml")
  ]
  set {
    name  = "argocdLocal.ingressIstio.annotations.kubernetes\\.io/ingress\\.global-static-ip-name"
    value = google_compute_global_address.global_address[3].name
  }
  set {
    name  = "argocdLocal.ingressIstio.hosts"
    value = "{${join(",", ["argo-cd.${var.base_domain}"])}}"
  }
  set {
    name  = "argocdLocal.rootApplication.repoPath"
    value = "${var.env}/argocd-applications"
  }
  set {
    name  = "argocdLocal.rootApplication.repoUrl"
    value = var.env_repo_ssh_url
  }
  set {
    name  = "argo-cd.server.config.dex\\.config"
    value = <<EOT
       connectors:
       - config:
           issuer: https://accounts.google.com
           clientID: ${var.argocd_oauth_client_id}
           clientSecret: ${var.argocd_oauth_client_secret}
         type: oidc
         id: google
         name: Google
      EOT 
  }
  set {
    name  = "argo-cd.server.config.repositories"
    value = <<EOT
       - url: ${var.env_repo_ssh_url}
         sshPrivateKeySecret:
           name: ${kubernetes_secret.repo_ssh_key.metadata[0].name}
           key: sshPrivateKey
      EOT 
  }
  set {
    name  = "argo-cd.server.config.url"
    value = "https://argo-cd.${var.base_domain}"
  }
}

