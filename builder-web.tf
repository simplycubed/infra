resource "kubernetes_secret" "builder_web" {
  metadata {
    name = "builder-web"
  }
  data = {
    VUE_APP_PROJECT_ID          = var.project_id
    VUE_APP_API_KEY             = var.firebase_api_key
    VUE_APP_AUTH_DOMAIN         = var.firebase_auth_domain
    VUE_APP_STORAGE_BUCKET      = var.firebase_storage_bucket
    VUE_APP_MESSAGING_SENDER_ID = var.firebase_messaging_sender_id
    VUE_APP_APP_ID              = var.firebase_app_id
  }
}
