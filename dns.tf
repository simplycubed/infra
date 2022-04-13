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
        "\"v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCkjnypyAHInjvAovmpZH8+IkEyaHEWhmWTZMjMdF1ApsniivkaJMm3OmFu4IoHPNYu8z/FAvARg+Yr4sEdkSUXCaBwjYay6QFP7FFcb9PEvFRB7Q/VLRnFcejgNG4vWuR4fHi40roK6OpJZUhjtA9v92hcDaQGi8SW1pOq1C3dRQIDAQAB\""
      ]
    },
    {
      name = ""
      type = "TXT"
      ttl  = 300
      records = [
        "\"v=spf1 include:_spf.google.com include:_spf.firebasemail.com include:sendgrid.net ~all\""
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
      name = "25532353"
      type = "CNAME"
      ttl  = 60
      records = [
        "sendgrid.net.",
      ]
    },
    {
      name = "em4847"
      type = "CNAME"
      ttl  = 60
      records = [
        "u25532353.wl104.sendgrid.net.",
      ]
    },
    {
      name = "s1._domainkey"
      type = "CNAME"
      ttl  = 60
      records = [
        "s1.domainkey.u25532353.wl104.sendgrid.net.",
      ]
    },
    {
      name = "s2._domainkey"
      type = "CNAME"
      ttl  = 60
      records = [
        "s2.domainkey.u25532353.wl104.sendgrid.net.",
      ]
    },
    {
      name = "url5910"
      type = "CNAME"
      ttl  = 60
      records = [
        "sendgrid.net.",
      ]
    },
    {
      name = "_github-pages-challenge-simplycubed"
      type = "TXT"
      ttl  = 300
      records = [
        "bb293bc4951f0d728586ae7bad2676"
      ]
    },
    {
      name = "security-policies"
      type = "CNAME"
      ttl  = 60
      records = [
        "ghs.googlehosted.com.",
      ]
    },
  ]
}
