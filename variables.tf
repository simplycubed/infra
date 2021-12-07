variable "argocd_oauth_client_id" {
  description = "Oauth client secret for argocd sso"
}

variable "argocd_oauth_client_secret" {
  description = "Oauth client secret for argocd sso"
}

variable "base_domain" {
  description = "Base domain for DNS records"
}

variable "cloudsql_password" {
  description = "Password for cloudsql instance"
  sensitive   = true
}

variable "cloudsql_username" {
  description = "username for cloudsql instance"
  sensitive   = true
}

variable "credentials" {
  description = "Service account to authenticate to gcloud"
  sensitive   = true
}

variable "db_machine_type" {}
variable "db_deletion_protection" {
  default = true
}

variable "env" {
  description = "Env Name"
}

variable "env_repo_cloudbuild" {
  description = "Environment repo cloudbuild key"
}

variable "env_repo_ssh_key" {
  description = "Environment repo ssh key"
}

variable "env_repo_ssh_url" {
  description = "SSH repo url of environment repo"
}

variable "github_client_id" {
  description = "GitHub Client ID"
  sensitive   = true
}

variable "github_client_secret" {
  description = "GitHub Client Secret"
  sensitive   = true
}

variable "gke_initial_node_count" {
  description = "initial count of gke cluster node"
}

variable "gke_cluster_name" {
  description = "name of gke cluster"
}

variable "gke_machine_type" {
  description = "Machine types used in gke cluster"
}

variable "grafana_oauth_client_id" {
  description = "Oauth client id for grafana SSO"
}

variable "grafana_oauth_client_secret" {
  description = "Oauth client secret for grafana SSO"
}

variable "iap_brand_name" {}

variable "iap_domain" {}

variable "project_id" {
  description = "Project for gcloud resources"
}

variable "region" {
  description = "Region for gcloud resources"
}
variable "source_graph_client_id" {
  description = "source graph client id"
}

variable "source_graph_client_secret" {
  description = "source graph client id"
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
