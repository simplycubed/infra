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

# VUE_APP
resource "google_secret_manager_secret" "vue_app_api_key" {
  secret_id = "vue-app-api-key"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "vue_app_api_key_version" {
  secret      = google_secret_manager_secret.vue_app_api_key.id
  secret_data = var.firebase_api_key
}

resource "google_secret_manager_secret" "vue_app_auth_domain" {
  secret_id = "vue-app-auth-domain"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "vue_app_auth_domain_version" {
  secret      = google_secret_manager_secret.vue_app_auth_domain.id
  secret_data = var.firebase_auth_domain
}

resource "google_secret_manager_secret" "vue_app_storage_bucket" {
  secret_id = "vue-app-storage-bucket"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "vue_app_storage_bucket_version" {
  secret      = google_secret_manager_secret.vue_app_storage_bucket.id
  secret_data = var.firebase_storage_bucket
}

resource "google_secret_manager_secret" "vue_app_messaging_sender_id" {
  secret_id = "vue-app-messaging-sender-id"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "vue_app_messaging_sender_id_version" {
  secret      = google_secret_manager_secret.vue_app_messaging_sender_id.id
  secret_data = var.firebase_messaging_sender_id
}

resource "google_secret_manager_secret" "vue_app_app_id" {
  secret_id = "vue-app-app-id"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "vue_app_app_id_version" {
  secret      = google_secret_manager_secret.vue_app_app_id.id
  secret_data = var.firebase_app_id
}
