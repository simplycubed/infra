module "first" {
  source                            = "terraform-google-modules/gcloud/google"
  platform                          = "linux"
  additional_components             = ["beta"]
  skip_download                     = false
  use_tf_google_credentials_env_var = true
  create_cmd_body                   = "beta functions list --project ${var.project_id} --region=${var.region}"
}

module "second" {
  source                            = "terraform-google-modules/gcloud/google"
  platform                          = "linux"
  additional_components             = ["beta"]
  skip_download                     = true
  use_tf_google_credentials_env_var = true
  create_cmd_body                   = "beta functions list --project ${var.project_id} --region=${var.region}"
  module_depends_on = [
    module.first
  ]
}