data "google_project" "project" {}

resource "google_project_iam_member" "project" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${data.google_project.project.number}@cloudbuild.gserviceaccount.com"
}

resource "google_service_account" "firebase" {
  project      = var.project_id
  account_id   = "firebase"
  display_name = "firebase"
}

resource "google_project_iam_member" "firebase" {
  role   = "roles/firebase.viewer"
  member = "serviceAccount:${google_service_account.firebase.email}"
}

resource "google_service_account_key" "firebase" {
  service_account_id = google_service_account.firebase.name
}

resource "kubernetes_secret" "firebase" {
  metadata {
    name = "firebase"
  }
  data = {
    "firebase.json" = base64decode(google_service_account_key.firebase.private_key)
  }
}
