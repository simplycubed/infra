module "builder_api" {
  source              = "garbetjie/cloud-run/google"
  name                = "builder-api"
  image               = "gcr.io/${var.project_id}/${var.builder_api_image}"
  location            = var.region
  map_domains         = ["builder-api.${var.base_domain}"]
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

module "builder_github" {
  source              = "garbetjie/cloud-run/google"
  name                = "builder-github"
  image               = "gcr.io/${var.project_id}/${var.builder_github_image}"
  location            = var.region
  map_domains         = ["builder-github.${var.base_domain}"]
  allow_public_access = false
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

module "registry_api" {
  source              = "garbetjie/cloud-run/google"
  name                = "registry-api"
  image               = "gcr.io/${var.project_id}/${var.registry_api_image}"
  location            = var.region
  allow_public_access = true
  map_domains         = ["registry-api.${var.base_domain}"]
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

module "registry_etl" {
  source              = "garbetjie/cloud-run/google"
  name                = "registry-etl"
  image               = "gcr.io/${var.project_id}/${var.registry_etl_image}"
  location            = var.region
  allow_public_access = false
  map_domains         = ["registry-etl.${var.base_domain}"]
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
