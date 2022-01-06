terraform {
  cloud {
    organization = "simplycubed"
    hostname     = "app.terraform.io"

    workspaces {
      name = "builder-infra-dev"
    }
  }
}
