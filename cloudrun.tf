module "builder_api" {
  source              = "simplycubed/cloud-run/google"
  version             = "2.2.3"
  name                = "builder-api"
  image               = "gcr.io/${var.project_id}/${var.default_image}"
  location            = var.region
  map_domains         = ["api.${var.base_domain}"]
  allow_public_access = true
  env = [
    { key = "ENV", value = "${var.env}" },
    { key = "ALLOWED_ORIGIN", value = "*" },
    { key = "FIREBASE_URL", value = "simplycubed-builder-${var.env}.firebaseapp.com" },
    { key = "FIREBASE_CREDENTIALS", value = "/etc/secrets/firebase.json" },
    { key = "FRONTEND_URL", value = "https://app.${var.base_domain}" }
  ]
  volumes = [
    { path = "/etc/secrets", secret = "projects/${var.project_id}/secrets/firebase-service-account",items = { key = "latest",path = "firebase.json"} }
  ]
}

module "registry_api" {
  source              = "simplycubed/cloud-run/google"
  version             = "2.2.3"
  name                = "registry-api"
  image               = "gcr.io/${var.project_id}/${var.default_image}"
  location            = var.region
  allow_public_access = true
  map_domains         = ["registry-api.${var.base_domain}"]
  env = [
    { key = "ENV", value = "${var.env}" },
    { key = "ALLOWED_ORIGIN", value = "*" },
    { key = "FIREBASE_URL", value = "simplycubed-builder-${var.env}.firebaseapp.com" },
    { key = "FIREBASE_CREDENTIALS", value = "/etc/secrets/firebase.json" },
    { key = "FRONTEND_URL", value = "https://app.simplycubed.${var.base_domain}" }
  ]
  volumes = [
    { path = "/etc/secrets", secret = "projects/${var.project_id}/secrets/firebase-service-account",items = { key = "latest",path = "firebase.json"} }
  ]
}

module "registry_etl" {
  source              = "simplycubed/cloud-run/google"
  version             = "2.2.3"
  name                = "registry-etl"
  image               = "gcr.io/${var.project_id}/${var.default_image}"
  location            = var.region
  allow_public_access = false
  map_domains         = ["registry-etl.${var.base_domain}"]
  env = [
    { key = "ENV", value = "${var.env}" },
    { key = "ALLOWED_ORIGIN", value = "*" },
    { key = "FIREBASE_URL", value = "simplycubed-builder-${var.env}.firebaseapp.com" },
    { key = "FIREBASE_CREDENTIALS", value = "/etc/secrets/firebase.json" },
    { key = "FRONTEND_URL", value = "https://app.simplycubed.${var.base_domain}" }
  ]
  volumes = [
    { path = "/etc/secrets", secret = "projects/${var.project_id}/secrets/firebase-service-account",items = { key = "latest",path = "firebase.json"} }
  ]
}
