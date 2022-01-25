# Configuration
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/identity_platform_default_supported_idp_config

resource "google_identity_platform_default_supported_idp_config" "github" {
  enabled       = true
  idp_id        = "github.com"
  client_id     = var.github_client_id
  client_secret = var.github_client_secret
}


