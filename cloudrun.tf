module "api" {
  source              = "garbetjie/cloud-run/google"
  name                = "api"
  image               = "gcr.io/${var.project_id}/${var.builder_api_image}"
  location            = var.region
  allow_public_access = true
  http2               = true
  env = [
    { key = "ENV", value = "dev" },
    { key = "ALLOWED_ORIGIN", value = "*" },
    { key = "FIREBASE_URL", value = "simplycubed-builder-dev.firebaseapp.com" },
    { key = "FIREBASE_CREDENTIALS", value = "/etc/secrets/firebase.json" },
    { key = "FRONTEND_URL", value = "https://app.simplycubed.dev" },
    { key = "PORT", value = "8080" }
  ]
  volumes = [
    { path = "/etc/secrets/firebase.json", secret = "projects/${var.project_id}/secrets/firebase-service-account" }
  ]
}

resource "google_cloud_run_domain_mapping" "api" {
  location = var.region
  name     = "api-run.${var.base_domain}"
  metadata {
    namespace = var.project_id
  }
  spec {
    route_name = module.api.id
  }
}

module "registry" {
  source              = "garbetjie/cloud-run/google"
  name                = "registry"
  image               = "gcr.io/${var.project_id}/${var.registry_api_image}"
  location            = var.region
  allow_public_access = true
  http2               = true
  env = [
    { key = "ENV", value = "dev" },
    { key = "ALLOWED_ORIGIN", value = "*" },
    { key = "FIREBASE_URL", value = "simplycubed-builder-dev.firebaseapp.com" },
    { key = "FIREBASE_CREDENTIALS", value = "/etc/secrets/firebase.json" },
    { key = "FRONTEND_URL", value = "https://app.simplycubed.dev" },
    { key = "PORT", value = "8080" }
  ]
  volumes = [
    { path = "/etc/secrets/firebase.json", secret = "projects/${var.project_id}/secrets/firebase-service-account" }
  ]
}

resource "google_cloud_run_domain_mapping" "registry" {
  location = var.region
  name     = "registry-run.${var.base_domain}"
  metadata {
    namespace = var.project_id
  }
  spec {
    route_name = module.registry.id
  }
}
