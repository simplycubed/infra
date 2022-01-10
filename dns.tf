
module "dns" {
  source     = "terraform-google-modules/cloud-dns/google"
  type       = "public"
  project_id = var.project_id
  name       = "builder-dns"
  domain     = "${var.base_domain}."
  recordsets = [
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
      name = "app"
      type = "A"
      ttl  = 60
      records = [
        google_compute_global_address.global_address[4].address,
      ]
    },
    {
      name = "api"
      type = "A"
      ttl  = 60
      records = [
        google_compute_global_address.global_address[5].address,
      ]
    },
    {
      name = "source-graph"
      type = "A"
      ttl  = 60
      records = [
        google_compute_global_address.global_address[6].address,
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
    {
      name = "registry"
      type = "A"
      ttl  = 60
      records = [
        google_compute_global_address.global_address[7].address,
      ]
    },
    {
      name    = module.api.dns[0].name
      type    = module.api.dns[0].type
      ttl     = 60
      records = module.api.dns[0].rrdatas[0]
    },
    {
      name    = module.registry.dns[0].name
      type    = module.registry.dns[0].type
      ttl     = 60
      records = module.registry.dns[0].rrdatas[0]
    },
  ]
}
