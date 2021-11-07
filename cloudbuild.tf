#
# golang
#
resource "google_cloudbuild_trigger" "push_golang_base_image" {
  name = "push-golang-base-image"

  github {
    owner = "simplycubed"
    name  = "golang"
    push {
      branch = "^main$"
    }
  }

  filename = "cloudbuild.yaml"

  tags = ["managed by terraform"]
}

#
# node
#
resource "google_cloudbuild_trigger" "push_node_base_image" {
  name = "push-node-base-image"

  github {
    owner = "simplycubed"
    name  = "node"
    push {
      branch = "^main$"
    }
  }

  filename = "cloudbuild.yaml"

  tags = ["managed by terraform"]
}

#
# nginx
#
resource "google_cloudbuild_trigger" "push_nginx_base_image" {
  name = "push-nginx-base-image"

  github {
    owner = "simplycubed"
    name  = "nginx"
    push {
      branch = "^main$"
    }
  }

  filename = "cloudbuild.yaml"

  tags = ["managed by terraform"]
}


#
# builder-web
#
resource "google_cloudbuild_trigger" "deploy_builder_web" {
  name = "deploy-builder-web"

  github {
    owner = "simplycubed"
    name  = "builder-web"
    push {
      tag    = var.env == "prod" ? "^production-v\\d+\\.\\d+\\.\\d+$" : null
      branch = var.env == "dev" ? "^main$" : null
    }
  }

  substitutions = {
    _ENV = var.env
  }

  filename = "cloudbuild.main.yaml"

  tags = ["managed by terraform"]
}

resource "google_cloudbuild_trigger" "build_builder_web" {
  count = var.env == "prod" ? 0 : 1

  name = "build-builder-web"

  github {
    owner = "simplycubed"
    name  = "builder-web"
    pull_request {
      branch = ".*"
    }
  }

  filename = "cloudbuild.pr.yaml"

  tags = ["managed by terraform"]
}

#
# builder-api
#
resource "google_cloudbuild_trigger" "deploy_builder_api" {
  name = "deploy-builder-api"

  github {
    owner = "simplycubed"
    name  = "builder-api"
    push {
      tag    = var.env == "prod" ? "^production-v\\d+\\.\\d+\\.\\d+$" : null
      branch = var.env == "dev" ? "^main$" : null
    }
  }

  substitutions = {
    _ENV = var.env
  }

  filename = "cloudbuild.main.yaml"

  tags = ["managed by terraform"]
}

resource "google_cloudbuild_trigger" "build_builder_api" {
  count = var.env == "prod" ? 0 : 1

  name = "build-builder-api"

  github {
    owner = "simplycubed"
    name  = "builder-api"
    pull_request {
      branch = ".*"
    }
  }

  filename = "cloudbuild.pr.yaml"

  tags = ["managed by terraform"]
}
