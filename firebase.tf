resource "google_firebase_project" "default" {
  provider = google-beta
  project  = data.google_project.project.project_id
}

data "google_firebase_web_app" "builder" {
  provider = google-beta
  app_id   = "simplycubed-builder-${var.env}"

  depends_on = [google_firebase_project.default]
}

data "google_firebase_web_app_config" "builder" {
  provider   = google-beta
  web_app_id = data.google_firebase_web_app.builder.app_id
}

data "google_storage_bucket" "builder" {
  provider = google-beta
  name     = "simplycubed-builder-${var.env}"
}

resource "google_storage_bucket_object" "builder" {
  provider = google-beta
  bucket   = data.google_storage_bucket.builder.name
  name     = "firebase-config.json"

  content = jsonencode({
    appId             = data.google_firebase_web_app.builder.app_id
    apiKey            = data.google_firebase_web_app_config.builder.api_key
    authDomain        = data.google_firebase_web_app_config.builder.auth_domain
    databaseURL       = lookup(data.google_firebase_web_app_config.builder, "database_url", "")
    storageBucket     = lookup(data.google_firebase_web_app_config.builder, "storage_bucket", "")
    messagingSenderId = lookup(data.google_firebase_web_app_config.builder, "messaging_sender_id", "")
    measurementId     = lookup(data.google_firebase_web_app_config.builder, "measurement_id", "")
  })
}