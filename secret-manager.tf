# CLOUD SQL CERTS
resource "google_secret_manager_secret" "cloud_sql_client_key" {
  secret_id = "cloud-sql-client-key-pem"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "cloud_sql_client_key_version" {
  secret      = google_secret_manager_secret.cloud_sql_client_key.id
  secret_data = google_sql_ssl_cert.cloudsql.private_key
}

resource "google_secret_manager_secret" "cloud_sql_client_cert" {
  secret_id = "cloud-sql-client-cert-pem"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "cloud_sql_client_cert_version" {
  secret      = google_secret_manager_secret.cloud_sql_client_cert.id
  secret_data = google_sql_ssl_cert.cloudsql.cert
}

resource "google_secret_manager_secret" "cloud_sql_server_ca" {
  secret_id = "cloud-sql-server-ca-pem"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "cloud_sql_server_ca_version" {
  secret      = google_secret_manager_secret.cloud_sql_server_ca.id
  secret_data = google_sql_ssl_cert.cloudsql.server_ca_cert
}

# CLOUD SQL BUILDER
resource "google_secret_manager_secret" "cloud_sql_user_builder_name" {
  secret_id = "cloud-sql-user-builder-name"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "cloud_sql_user_builder_name_version" {
  secret      = google_secret_manager_secret.cloud_sql_user_builder_name.id
  secret_data = google_sql_user.builder.name
}

resource "google_secret_manager_secret" "cloud_sql_user_builder_password" {
  secret_id = "cloud-sql-client-cert-pem"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "cloud_sql_user_builder_password_version" {
  secret      = google_secret_manager_secret.cloud_sql_user_builder_password.id
  secret_data = google_sql_user.builder.password
}

# CLOUD SQL REGISTRY
resource "google_secret_manager_secret" "cloud_sql_user_registry_name" {
  secret_id = "cloud-sql-user-registry-name"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "cloud_sql_user_registry_name_version" {
  secret      = google_secret_manager_secret.cloud_sql_user_registry_name.id
  secret_data = google_sql_user.registry.name
}

resource "google_secret_manager_secret" "cloud_sql_user_registry_password" {
  secret_id = "cloud-sql-user-registry-password"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "cloud_sql_user_registry_password_version" {
  secret      = google_secret_manager_secret.cloud_sql_user_registry_password.id
  secret_data = google_sql_user.registry.password
}

# ENV_REPO_CLOUDBUILD
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

# FIREBASE
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
