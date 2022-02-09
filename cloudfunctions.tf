module "first" {
  source                            = "terraform-google-modules/gcloud/google"
  platform                          = "linux"
  additional_components             = ["beta"]
  skip_download                     = false
  use_tf_google_credentials_env_var = true
  create_cmd_body                   = "beta functions list --project ${var.project_id} --regions=${var.region}"
}

module "second" {
  source                            = "terraform-google-modules/gcloud/google"
  platform                          = "linux"
  additional_components             = ["beta"]
  skip_download                     = false
  use_tf_google_credentials_env_var = true
  create_cmd_body                   = "beta functions list --project ${var.project_id} --regions=${var.region}"
  depends_on = [
    module.first
  ]
}
