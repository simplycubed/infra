data "google_firebase_project" "default" {
  provider = google-beta
  project  = data.google_project.project.project_id
}

resource "google_firebase_project_location" "default" {
  provider = google-beta
  project  = data.google_firebase_project.default.project

  location_id = "us-central"
}

locals {
  web = [
    "builder",
    "registry",
  ]
}

resource "google_firebase_web_app" "default" {
  count        = length(local.web)
  provider     = google-beta
  project      = data.google_project.project.project_id
  display_name = local.web[count.index]

  depends_on = [data.google_firebase_project.default]
}

data "google_firebase_web_app_config" "default" {
  count      = length(local.web)
  provider   = google-beta
  web_app_id = google_firebase_web_app.default[count.index].app_id
}

resource "google_storage_bucket" "default" {
  count    = length(local.web)
  provider = google-beta
  name     = "simplycubed-builder-${var.env}-${local.web[count.index]}"
  location = "US"
}

resource "google_storage_bucket_object" "default" {
  count    = length(local.web)
  provider = google-beta
  bucket   = google_storage_bucket.default[count.index].name
  name     = "firebase-config.json"

  content = jsonencode({
    appId             = google_firebase_web_app.default[count.index].app_id
    apiKey            = data.google_firebase_web_app_config.default[count.index].api_key
    authDomain        = data.google_firebase_web_app_config.default[count.index].auth_domain
    databaseURL       = lookup(data.google_firebase_web_app_config.default[count.index], "database_url", "")
    storageBucket     = lookup(data.google_firebase_web_app_config.default[count.index], "storage_bucket", "")
    messagingSenderId = lookup(data.google_firebase_web_app_config.default[count.index], "messaging_sender_id", "")
    measurementId     = lookup(data.google_firebase_web_app_config.default[count.index], "measurement_id", "")
  })
}
