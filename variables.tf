variable "base_domain" {
  description = "Base domain for DNS records"
}

variable "google_domainkey" {
  description = "Google Domain Key"
}

variable "google_site_verification" {
  description = "Google Site Verification"
}

variable "project_id" {
  description = "Project for gcloud resources"
}

variable "region" {
  description = "Region for gcloud resources"
}

variable "firebase_app_id" {
  description = "Firebase App ID"
}

variable "firebase_api_key" {
  description = "Firebase API Key"
}

variable "firebase_auth_domain" {
  description = "Firebase Auth Domain"
}

variable "firebase_storage_bucket" {
  description = "Firebase Storage Bucket"
}

variable "firebase_messaging_sender_id" {
  description = "Firebase Messaging Sender ID"
}
