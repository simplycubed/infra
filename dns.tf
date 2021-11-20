
module "dns" {
  source     = "terraform-google-modules/cloud-dns/google"
  type       = "public"
  project_id = var.project_id
  name       = "builder-dns"
  domain     = "${var.base_domain}."
  recordsets = [
    {
      name = "build"
      type = "CNAME"
      ttl  = 60
      records = [
        "ghs.googlehosted.com.",
      ]
    },
    {
      name = "prometheus"
      type = "A"
      ttl  = 60
      records = [
        google_compute_global_address.global_address[0].address,
      ]
    },
    {
      name = "grafana"
      type = "A"
      ttl  = 60
      records = [
        google_compute_global_address.global_address[1].address,
      ]
    },
    {
      name = "alert-manager"
      type = "A"
      ttl  = 60
      records = [
        google_compute_global_address.global_address[2].address,
      ]
    },
    {
      name = "argo-cd"
      type = "A"
      ttl  = 60
      records = [
        google_compute_global_address.global_address[3].address,
      ]
    },
    {
      name = "www"
      type = "CNAME"
      ttl  = 60
      records = [
        "20913630.group30.sites.hubspot.net.",
      ]
    },
    {
      name = ""
      type = "A"
      ttl  = 60
      records = [
        "199.60.103.31",
        "199.60.103.131"
      ]
    },
  ]
}