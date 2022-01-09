module "api" {
  source   = "garbetjie/cloud-run/google"
  name     = "api"
  image    = "gcr.io/${var.project_id}/${var.builder_api_image}"
  location = var.region
  env = [
    { key = "ENV", value = "dev" },
    { key = "ALLOWED_ORIGIN", value = "*" },
    { key = "FIREBASE_URL", value = "simplycubed-builder-dev.firebaseapp.com" },
    { key = "FIREBASE_CREDENTIALS", value = "/etc/secrets/firebase.json" },
    { key = "FRONTEND_URL", value = "https://app.simplycubed.dev" },
    { key = "PORT", value = "8080" },
    { key = "BUILDER_SQL_HOST", value = google_sql_database_instance.instance.ip_address.0.ip_address },
    { key = "BUILDER_SQL_PORT", value = "5432" }
  ]
  volumes = [
    { path = "/etc/secrets/firebase.json", secret = "projects/${var.project_id}/secrets/firebase-service-account" },
    { path = "/etc/certs/cloudsql/client-cert.pem", secret = "projects/${var.project_id}/secrets/cloud-sql-client-key-pem" },
    { path = "/etc/certs/cloudsql/client-key.pem", secret = "projects/${var.project_id}/secrets/cloud-sql-client-cert-pem" },
    { path = "/etc/certs/cloudsql/server-ca.pem", secret = "projects/${var.project_id}/secrets/cloud-sql-server-ca-pem" }
  ]
}

    # { key = "BUILDER_SQL_NAME", value = google_sql_database.builder.name },
    # { key = "BUILDER_SQL_USER", value = google_sql_user.builder.name },
    # { key = "BUILDER_SQL_PASS", value = google_sql_user.builder.password }

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
  source   = "garbetjie/cloud-run/google"
  name     = "registry"
  image    = "gcr.io/${var.project_id}/${var.registry_api_image}"
  location = var.region
  env = [
    { key = "ENV", value = "dev" },
    { key = "ALLOWED_ORIGIN", value = "*" },
    { key = "FIREBASE_URL", value = "simplycubed-builder-dev.firebaseapp.com" },
    { key = "FIREBASE_CREDENTIALS", value = "/etc/secrets/firebase.json" },
    { key = "FRONTEND_URL", value = "https://app.simplycubed.dev" },
    { key = "PORT", value = "8080" },
    { key = "REGISTRY_SQL_HOST", value = google_sql_database_instance.instance.ip_address.0.ip_address },
    { key = "REGISTRY_SQL_PORT", value = "5432" }
  ]
  volumes = [
    { path = "/etc/secrets/firebase.json", secret = "projects/${var.project_id}/secrets/firebase-service-account" },
    { path = "/etc/certs/cloudsql/client-cert.pem", secret = "projects/${var.project_id}/secrets/cloud-sql-client-key-pem" },
    { path = "/etc/certs/cloudsql/client-key.pem", secret = "projects/${var.project_id}/secrets/cloud-sql-client-cert-pem" },
    { path = "/etc/certs/cloudsql/server-ca.pem", secret = "projects/${var.project_id}/secrets/cloud-sql-server-ca-pem" }
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

    
    # { key = "REGISTRY_SQL_NAME", value = google_sql_database.registry.name },
    # { key = "REGISTRY_SQL_USER", value = google_sql_user.registry.name },
    # { key = "REGISTRY_SQL_PASS", value = google_sql_user.registry.password }