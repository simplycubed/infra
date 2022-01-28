# locals {
#   api_config_id_prefix     = "api"
#   api_gateway_container_id = "api-gw"
#   gateway_id               = "gw"
# }

# resource "google_api_gateway_api" "api" {
#   provider     = google-beta
#   api_id       = local.api_gateway_container_id
#   display_name = "api"
# }

# resource "google_api_gateway_api_config" "api" {
#   provider      = google-beta
#   api           = google_api_gateway_api.api.api_id
#   api_config_id = local.api_config_id_prefix
#   display_name  = "config"
#   openapi_documents {
#     document {
#       path     = "spec.yaml"
#       contents = filebase64("apis/${var.env}/spec.yaml")
#     }
#   }
#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "google_api_gateway_gateway" "api" {
#   provider     = google-beta
#   region       = var.region
#   api_config   = google_api_gateway_api_config.api.id
#   gateway_id   = local.gateway_id
#   display_name = "gateway"
#   depends_on   = [google_api_gateway_api_config.api]
# }
