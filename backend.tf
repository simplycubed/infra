terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "simplycubed"

    workspaces {
      prefix = "builder-infra-"
    }
  }
}

