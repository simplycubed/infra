variable "project_id" {
  description = "Project for gcloud resources"
}

variable "env" {
  description = "Env Name"
}

variable "region" {
  description = "Region for gcloud resources"
}

variable "credentials" {
  description = "Service account to authenticate to gcloud"
  sensitive   = true
}

variable "base_domain" {
  description = "Base domain for DNS records"
}

variable "cloudsql_username" {
  description = "username for cloudsql instance"
  sensitive   = true
}

variable "cloudsql_password" {
  description = "Password for cloudsql instance"
  sensitive   = true
}