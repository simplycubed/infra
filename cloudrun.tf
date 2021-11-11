module frontend {
  source = "garbetjie/cloud-run/google"

  # Required parameters
  name = "frontend"
  image = "asia.gcr.io/${var.project_id}/${var.frontend_image}"
  location = var.region
}

resource "google_cloud_run_domain_mapping" "frontend" {
  location = var.region
  name     = "build.${var.base_domain}"

  metadata {
    namespace = var.project_id
  }

  spec {
    route_name = module.frontend.id
  }
}

module api {
  source = "garbetjie/cloud-run/google"

  # Required parameters
  name = "api"
  image = "asia.gcr.io/${var.project_id}/${var.api_image}"
  location = var.region
}

resource "google_cloud_run_domain_mapping" "api" {
  location = var.region
  name     = "api.${var.base_domain}"

  metadata {
    namespace = var.project_id
  }

  spec {
    route_name = module.api.id
  }
}