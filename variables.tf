variable "base_domain" {
  description = "Base domain for DNS records"
}

variable "builder_api_url" {
  description = "Builder API URL"
}

# will use the sample-service as the base image
variable "default_image" {
  description = "Default Cloud Run image used to create instance using Terraform"
}

variable "credentials" {
  description = "Service account to authenticate to gcloud"
  sensitive   = true
}

variable "env" {
  description = "Env Name"
}

variable "google_domainkey" {
  description = "Google Domain Key"
}

variable "google_site_verification" {
  description = "Google Site Verification"
}

variable "iap_brand_name" {
  description = "IAP Brand Name"
}

variable "iap_domain" {
  description = "IAP Domain"
}

variable "project_id" {
  description = "Project for gcloud resources"
}

variable "region" {
  description = "Region for gcloud resources"
}

# project settings in firebase.google.com
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

# need to create a github oauth client for devopsui
variable "github_client_id" {
  description = "GitHub OAuth Client ID"
}

variable "github_client_secret" {
  description = "GitHub OAuth Client Secret"
  sensitive   = true
}

variable "registry_api_url" {
  description = "Registry API URL"
}
