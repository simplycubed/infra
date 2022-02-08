module "dns" {
  source     = "terraform-google-modules/cloud-dns/google"
  type       = "public"
  project_id = var.project_id
  name       = "simplycubed-dns"
  domain     = "${var.base_domain}."
  recordsets = [
    {
      name = "www"
      type = "A"
      ttl  = 60
      records = [
        "199.36.158.100",
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
        "${var.google_domainkey}"
      ]
    },
    {
      name = ""
      type = "TXT"
      ttl  = 300
      records = [
        "google-site-verification=${var.google_site_verification}",
        "firebase=${var.project}",
        "\"v=spf1 include:_spf.google.com include:_spf.firebasemail.com ~all\""
      ]
    },
    {
      name = "_dmarc"
      type = "TXT"
      ttl  = 300
      records = [
        "\"v=DMARC1;\" \"p=quarantine;\" \"rua=mailto:dmarc@${var.base_domain};\" \"ruf=mailto:dmarc@${var.base_domain};\" \"fo=1:d:s\""
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
      name = "firebase1._domainkey"
      type = "CNAME"
      ttl  = 60
      records = [
        "mail-devopsui-com.dkim1._domainkey.firebasemail.com.",
      ]
    },
    {
      name = "firebase2._domainkey"
      type = "CNAME"
      ttl  = 60
      records = [
        "mail-devopsui-com.dkim2._domainkey.firebasemail.com.",
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
