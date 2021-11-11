
module "dns" {
  source     = "terraform-google-modules/cloud-dns/google"
  type       = "public"
  project_id = var.project_id
  name       = "builder-dns"
  domain     = "${var.base_domain}."
  recordsets = [
    {
      name = "www"
      type = "CNAME"
      ttl  = 60
      records = [
        "ghs.googlehosted.com.",
      ]
    },
  ]
}