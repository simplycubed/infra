module frontend {
  source = "garbetjie/cloud-run/google"

  # Required parameters
  name = "frontend"
  image = "gcr.io/${var.project_id}/${var.frontend_image}"
  location = var.region
}