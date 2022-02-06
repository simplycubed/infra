# FIREBASE SERVICE ACCOUNT
resource "google_secret_manager_secret" "firebase" {
  secret_id = "firebase-service-account"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "firebase_version" {
  secret      = google_secret_manager_secret.firebase.id
  secret_data = google_service_account_key.firebase.private_key
}

resource "google_secret_manager_secret" "vue_app_github_client_id" {
  secret_id = "vue-app-github-client-id"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "vue_app_github_client_id_version" {
  secret      = google_secret_manager_secret.vue_app_github_client_id.id
  secret_data = var.github_client_id
}
