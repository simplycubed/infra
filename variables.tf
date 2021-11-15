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

variable "github_client_id" {
  description = "GitHub Client ID"
  sensitive   = true
}

variable "github_client_secret" {
  description = "GitHub Client Secret"
  sensitive   = true
}

variable "gke_initial_node_count"{
  description = "initial count of gke cluster node"
}

variable "gke_cluster_name"{
   description = "name of gke cluster"
}

variable "gke_machine_type"{
  description = "Machine types used in gke cluster"
}

variable "grafana_oauth_client_id"{
  description = "Oauth client id for grafana SSO"
}


variable "grafana_oauth_client_secret"{
  description = "Oauth client secret for grafana SSO"
}

variable "env_repo_ssh_key"{
  description = "Environment repo ssh key"
}

variable "env_repo_ssh_url"{
  description = "SSH repo url of environment repo"
}

variable "argocd_oauth_client_secret"{
   description = "Oauth client secret for argocd sso"
}

variable "argocd_oauth_client_id"{
   description = "Oauth client secret for argocd sso"
}