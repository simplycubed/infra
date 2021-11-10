module frontend {
  source = "garbetjie/cloud-run/google"

  # Required parameters
  name = "frontend"
  image = "asia.gcr.io/${var.project_id}/${var.frontend_image}"
  location = var.region
}