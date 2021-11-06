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
