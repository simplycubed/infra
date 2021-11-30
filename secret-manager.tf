resource "google_secret_manager_secret" "env_repo_cloudbuild" {
  secret_id = "env-repo-cloudbuild"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "env_repo_cloudbuild_version" {
  secret      = google_secret_manager_secret.env_repo_cloudbuild.id
  secret_data = var.env_repo_cloudbuild
}
