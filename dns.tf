locals {
  google_site_verification = var.env == "prod" ? "E-DNc34OmbkUPcUw9FrzN9RN9WdGW6dk7FuD3NLYoic" : "TvTmlk3mbvtg38d3xFCZUJHT-vXkbgzV6CXHoiL2v0o"
}

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
    },
    {
      name = ""
      type = "MX"
      ttl  = 300
      records = [
        "10 aspmx.l.google.com.",
        "50 aspmx3.googlemail.com.",
        "40 aspmx2.googlemail.com.",
        "30 alt2.aspmx.l.google.com.",
        "20 alt1.aspmx.l.google.com.",
      ]
    },
    {
      name = "google._domainkey"
      type = "TXT"
      ttl  = 300
      records = [
        "\"v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCkjnypyAHInjvAovmpZH8+IkEyaHEWhmWTZMjMdF1ApsniivkaJMm3OmFu4IoHPNYu8z/FAvARg+Yr4sEdkSUXCaBwjYay6QFP7FFcb9PEvFRB7Q/VLRnFcejgNG4vWuR4fHi40roK6OpJZUhjtA9v92hcDaQGi8SW1pOq1C3dRQIDAQAB\""
      ]
    },
    {
      name = ""
      type = "TXT"
      ttl  = 300
      records = [
        "google-site-verification=${local.google_site_verification}",
        "firebase=simplycubed-builder-${var.env}",
        "\"v=spf1 include:_spf.google.com include:_spf.firebasemail.com ~all\""
      ]
    },
    {
      name = "_dmarc"
      type = "TXT"
      ttl  = 300
      records = [
        "\"v=DMARC1;\" \"p=quarantine;\" \"rua=mailto:dmarc@simplycubed.uriports.com;\" \"ruf=mailto:dmarc@simplycubed.uriports.com;\" \"fo=1:d:s\""
      ]
    },
    {
      name = "cal"
      type = "CNAME"
      ttl  = 60
      records = [
        "ghs.googlehosted.com.",
      ]
    },
    {
      name = "drive"
      type = "CNAME"
      ttl  = 60
      records = [
        "ghs.googlehosted.com.",
      ]
    },
    {
      name = "mail"
      type = "CNAME"
      ttl  = 60
      records = [
        "ghs.googlehosted.com.",
      ]
    },
    {
      name = "groups"
      type = "CNAME"
      ttl  = 60
      records = [
        "ghs.googlehosted.com.",
      ]
    },
    {
      name = "sites"
      type = "CNAME"
      ttl  = 60
      records = [
        "ghs.googlehosted.com.",
      ]
    },
    {
      name = "firebase1._domainkey"
      type = "CNAME"
      ttl  = 60
      records = [
        "mail-simplycubed-com.dkim1._domainkey.firebasemail.com.",
      ]
    },
    {
      name = "firebase2._domainkey"
      type = "CNAME"
      ttl  = 60
      records = [
        "mail-simplycubed-com.dkim2._domainkey.firebasemail.com.",
      ]
    },
    {
      name = "23352241"
      type = "CNAME"
      ttl  = 60
      records = [
        "sendgrid.net.",
      ]
    },
    {
      name = "em7387"
      type = "CNAME"
      ttl  = 60
      records = [
        "u23352241.wl242.sendgrid.net.",
      ]
    },
    {
      name = "s1._domainkey"
      type = "CNAME"
      ttl  = 60
      records = [
        "s1.domainkey.u23352241.wl242.sendgrid.net.",
      ]
    },
    {
      name = "s2._domainkey"
      type = "CNAME"
      ttl  = 60
      records = [
        "s2.domainkey.u23352241.wl242.sendgrid.net.",
      ]
    },
    {
      name = "url3202"
      type = "CNAME"
      ttl  = 60
      records = [
        "sendgrid.net.",
      ]
    },
  ]
}
