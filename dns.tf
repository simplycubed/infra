
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
      name = "app"
      type = "A"
      ttl  = 60
      records = [
        "199.36.158.100",
      ]
    },
    {
      name = "api"
      type = "CNAME"
      ttl  = 60
      records = [
        "ghs.googlehosted.com.",
      ]
    },
    {
      name = "builder-github"
      type = "CNAME"
      ttl  = 60
      records = [
        "ghs.googlehosted.com.",
      ]
    },
    {
      name = "registry"
      type = "A"
      ttl  = 60
      records = [
        "199.36.158.100",
      ]
    },
    {
      name = "registry-api"
      type = "CNAME"
      ttl  = 60
      records = [
        "ghs.googlehosted.com.",
      ]
    },
    {
      name = "registry-etl"
      type = "CNAME"
      ttl  = 60
      records = [
        "ghs.googlehosted.com.",
      ]
    }
  ]
}
