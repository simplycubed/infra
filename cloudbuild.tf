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
# python
#
resource "google_cloudbuild_trigger" "push_python_base_image" {
  name = "push-python-base-image"

  github {
    owner = "simplycubed"
    name  = "python"
    push {
      branch = "^main$"
    }
  }

  filename = "cloudbuild.yaml"

  tags = ["managed by terraform"]
}

#
# yq
#
resource "google_cloudbuild_trigger" "push_yq_base_image" {
  name = "push-yq-base-image"

  github {
    owner = "simplycubed"
    name  = "yq"
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

#
# registry-api
#
resource "google_cloudbuild_trigger" "deploy_registry_api" {
  name = "deploy-registry-api"

  github {
    owner = "simplycubed"
    name  = "registry-api"
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

resource "google_cloudbuild_trigger" "build_registry_api" {
  count = var.env == "prod" ? 0 : 1

  name = "build-registry-api"

  github {
    owner = "simplycubed"
    name  = "registry-api"
    pull_request {
      branch = ".*"
    }
  }

  filename = "cloudbuild.pr.yaml"

  tags = ["managed by terraform"]
}

#
# registry-etl
#
resource "google_cloudbuild_trigger" "deploy_registry_etl" {
  name = "deploy-registry-etl"

  github {
    owner = "simplycubed"
    name  = "registry-etl"
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

resource "google_cloudbuild_trigger" "build_registry_etl" {
  count = var.env == "prod" ? 0 : 1

  name = "build-registry-etl"

  github {
    owner = "simplycubed"
    name  = "registry-etl"
    pull_request {
      branch = ".*"
    }
  }

  filename = "cloudbuild.pr.yaml"

  tags = ["managed by terraform"]
}

#
# sample-service
#
resource "google_cloudbuild_trigger" "deploy_sample_service" {
  name = "deploy-sample-service"

  github {
    owner = "simplycubed"
    name  = "sample-service"
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

resource "google_cloudbuild_trigger" "build_sample_service" {
  count = var.env == "prod" ? 0 : 1

  name = "build-sample-service"

  github {
    owner = "simplycubed"
    name  = "sample-service"
    pull_request {
      branch = ".*"
    }
  }

  filename = "cloudbuild.pr.yaml"

  tags = ["managed by terraform"]
}
