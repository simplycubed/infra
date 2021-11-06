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

# terraform {
#   required_providers {
#     statuscake = {
#       source  = "StatusCakeDev/statuscake"
#       version = "1.0.1"
#     }
#   }
# }

# provider "statuscake" {
#   username = var.statuscake_user
#   apikey   = var.statuscake_token
# }
