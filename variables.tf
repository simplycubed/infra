variable "base_domain" {
  description = "Base domain for DNS records"
}

variable "default_image" {
  description = "Default Cloud Run image used to create instance using Terraform"
  type        = string
  default     = null
}

variable "env" {
  description = "Environment"
}

variable "project_id" {
  description = "Project ID"
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

variable "firebase_measurement_id" {
  description = "Firebase Measurement ID"
}
