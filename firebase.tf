# Shared
resource "google_firebase_project" "default" {
  provider = google-beta
  project  = data.google_project.project.project_id
}

# ${var.project_id}.appspot.com was automatically created
# Adding a new bucket due to domain verification error in TF
resource "google_storage_bucket" "default" {
  provider = google-beta
  name     = var.project_id
  location = "US"
}

#  Builder
resource "google_firebase_web_app" "builder" {
  provider     = google-beta
  project      = data.google_project.project.project_id
  display_name = var.project_id

  depends_on = [google_firebase_project.default]
}

data "google_firebase_web_app_config" "builder" {
  provider   = google-beta
  web_app_id = google_firebase_web_app.builder.id
}

# resource "google_storage_bucket_object" "builder" {
#   provider = google-beta
#   bucket   = google_storage_bucket.default.name
#   name     = "builder-firebase-config.json"

#   content = jsonencode({
#     appId             = google_firebase_web_app.builder.app_id
#     apiKey            = data.google_firebase_web_app_config.builder.api_key
#     authDomain        = data.google_firebase_web_app_config.builder.auth_domain
#     databaseURL       = lookup(data.google_firebase_web_app_config.builder, "database_url", "")
#     storageBucket     = lookup(data.google_firebase_web_app_config.builder, "storage_bucket", "")
#     messagingSenderId = lookup(data.google_firebase_web_app_config.builder, "messaging_sender_id", "")
#     measurementId     = lookup(data.google_firebase_web_app_config.builder, "measurement_id", "")
#   })
# }
