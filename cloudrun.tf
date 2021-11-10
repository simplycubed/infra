module frontend {
  source = "garbetjie/cloud-run/google"

  # Required parameters
  name = "frontend"
  image = "asia.gcr.io/${var.project_id}/${var.frontend_image}"
  location = var.region
}

module frontend {
  source = "garbetjie/cloud-run/google"

  # Required parameters
  name = "api"
  image = "asia.gcr.io/${var.project_id}/${var.api_image}"
  location = var.region
}