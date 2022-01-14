variable "base_domain" {
  description = "Base domain for DNS records"
}

variable "builder_api_image" {
  description = "builder-api image"
}

variable "builder_github_image" {
  description = "builder-github image"
}

variable "credentials" {
  description = "Service account to authenticate to gcloud"
  sensitive   = true
}

variable "env" {
  description = "Env Name"
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

variable "registry_etl_image" {
  description = "Registry ETL Image"
}

variable "registry_api_image" {
  description = "builder-api image"
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

variable "firebase_app_id" {
  description = "Firebase App ID"
}
