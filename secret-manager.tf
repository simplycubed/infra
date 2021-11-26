resource "google_secret_manager_secret" "env_repo_ssh" {
  secret_id = "env-repo-ssh-key"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "env_repo_ssh_version" {
  secret      = google_secret_manager_secret.env_repo_ssh.id
  secret_data = var.env_repo_ssh_key
}
