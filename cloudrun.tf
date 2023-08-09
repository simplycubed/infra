module "security_policies" {
  source              = "simplycubed/cloud-run-cicd-updates/google"
  version             = "2.2.3"
  name                = "security-policies"
  image               = "gcr.io/${var.project_id}/${var.default_image}"
  location            = var.region
  allow_public_access = false
  ingress             = "all"
  env = [
    { key = "ENV", value = "${var.env}" },
    { key = "ALLOWED_ORIGIN", value = "*" }
  ]
}

resource "google_compute_region_network_endpoint_group" "cloudrun" {
  name                  = "security-policies"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = module.security_policies.name
  }
  lifecycle {
    create_before_destroy = true
  }
}

module "lb-http" {
  source            = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  version           = "~> 9.0"

  project           = var.project_id
  name              = "cloudrun"

  ssl                             = true
  managed_ssl_certificate_domains = ["security-policies.${var.base_domain}"]
  https_redirect                  = true
  backends = {
    default = {
      description                     = null
      enable_cdn                      = false
      custom_request_headers          = null
      custom_response_headers         = null
      security_policy                 = null


      log_config = {
        enable = true
        sample_rate = 1.0
      }

      groups = [
        {
          # Your serverless service should have a NEG created that's referenced here.
          group = google_compute_region_network_endpoint_group.cloudrun.id
        }
      ]

      iap_config = {
        enable               = true
        oauth2_client_id     = google_iap_client.iap_client.client_id
        oauth2_client_secret = google_iap_client.iap_client.secret
      }
    }
  }
}