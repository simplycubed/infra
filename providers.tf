provider "google" {
  region      = var.region
  project     = var.project_id
  credentials = var.credentials
}

provider "google-beta" {
  region      = var.region
  project     = var.project_id
  credentials = var.credentials
}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = "https://${module.gke.endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(module.gke.ca_certificate)
  }
}
