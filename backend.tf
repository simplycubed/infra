terraform {
  cloud {
    organization = "devopsui"
    hostname     = "app.terraform.io"

    workspaces {
      tags = ["builder"]
    }
  }
}
