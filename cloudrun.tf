module "security" {
  source              = "simplycubed/cloud-run-cicd-updates/google"
  version             = "2.2.2"
  name                = "security"
  image               = "gcr.io/${var.project_id}/${var.default_image}"
  location            = var.region
  map_domains         = ["security.${var.base_domain}"]
  allow_public_access = false
  env = [
    { key = "ENV", value = "${var.env}" },
    { key = "ALLOWED_ORIGIN", value = "*" }
  ]
}
