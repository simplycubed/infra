terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "SimplyCubed"

    workspaces {
      prefix = "builder-infra-"
    }
  }
}

