resource "google_iap_web_iam_member" "access_iap_policy" {
  provider = google-beta
  project  = var.project_id
  role     = "roles/iap.httpsResourceAccessor"
  member   = "domain:${var.iap_domain}"
}

resource "google_iap_client" "iap_client" {
  provider     = google-beta
  display_name = "IAP Auth"
  brand        = google_iap_brand.project_brand.id
}

resource "google_iap_brand" "project_brand" {
  support_email     = "support@simplycubed.com"
  application_title = "Cloud IAP protected Application"
  project           = google_project_service.project_service.project
}