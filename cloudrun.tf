module "api" {
  source              = "garbetjie/cloud-run/google"
  name                = "api"
  image               = "gcr.io/${var.project_id}/${var.builder_api_image}"
  location            = var.region
  map_domains         = ["api-run.${var.base_domain}"]
  allow_public_access = true
  env = [
    { key = "ENV", value = "dev" },
    { key = "ALLOWED_ORIGIN", value = "*" },
    { key = "FIREBASE_URL", value = "simplycubed-builder-dev.firebaseapp.com" },
    { key = "FIREBASE_CREDENTIALS", value = "/etc/secrets/firebase.json" },
    { key = "FRONTEND_URL", value = "https://app.simplycubed.dev" }
  ]
  volumes = [
    { path = "/etc/secrets/firebase.json", secret = "projects/${var.project_id}/secrets/firebase-service-account" }
  ]
}

module "registry" {
  source              = "garbetjie/cloud-run/google"
  name                = "registry"
  image               = "gcr.io/${var.project_id}/${var.registry_api_image}"
  location            = var.region
  allow_public_access = true
  map_domains         = ["registry-run.${var.base_domain}"]
  env = [
    { key = "ENV", value = "dev" },
    { key = "ALLOWED_ORIGIN", value = "*" },
    { key = "FIREBASE_URL", value = "simplycubed-builder-dev.firebaseapp.com" },
    { key = "FIREBASE_CREDENTIALS", value = "/etc/secrets/firebase.json" },
    { key = "FRONTEND_URL", value = "https://app.simplycubed.dev" }
  ]
  volumes = [
    { path = "/etc/secrets/firebase.json", secret = "projects/${var.project_id}/secrets/firebase-service-account" }
  ]
}
