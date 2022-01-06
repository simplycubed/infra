resource "google_firebase_project" "default" {
  provider = google-beta
  project  = data.google_project.project.project_id
}

resource "google_firebase_project_location" "default" {
  provider = google-beta
  project  = google_firebase_project.default.project

  location_id = "us-central"
}

resource "google_firebase_web_app" "builder" {
  provider     = google-beta
  project      = data.google_project.project.project_id
  display_name = "builder"

  depends_on = [google_firebase_project.default]
}

data "google_firebase_web_app_config" "builder" {
  provider   = google-beta
  web_app_id = google_firebase_web_app.builder.app_id
}

resource "google_storage_bucket" "builder" {
  provider = google-beta
  name     = "simplycubed-builder-${var.env}"
  location = "US"
}

resource "google_storage_bucket_object" "builder" {
  provider = google-beta
  bucket   = google_storage_bucket.builder.name
  name     = "firebase-config.json"

  content = jsonencode({
    appId             = google_firebase_web_app.builder.app_id
    apiKey            = data.google_firebase_web_app_config.builder.api_key
    authDomain        = data.google_firebase_web_app_config.builder.auth_domain
    databaseURL       = lookup(data.google_firebase_web_app_config.builder, "database_url", "")
    storageBucket     = lookup(data.google_firebase_web_app_config.builder, "storage_bucket", "")
    messagingSenderId = lookup(data.google_firebase_web_app_config.builder, "messaging_sender_id", "")
    measurementId     = lookup(data.google_firebase_web_app_config.builder, "measurement_id", "")
  })
}
