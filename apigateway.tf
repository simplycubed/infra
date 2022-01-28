resource "google_api_gateway_api" "api" {
  provider = google-beta
  api_id   = "api"
}

resource "google_api_gateway_api_config" "api" {
  provider      = google-beta
  api           = google_api_gateway_api.api.api_id
  api_config_id = "cfg"
  openapi_documents {
    document {
      path     = "spec.yaml"
      contents = filebase64("apis/${var.env}/combined.yaml")
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}
