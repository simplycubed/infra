#
# firebase
#
resource "google_cloudbuild_trigger" "push_firebase_base_image" {
  name = "push-firebase-base-image"
  github {
    owner = "devopsui"
    name  = "firebase"
    push {
      branch = "^main$"
    }
  }
  filename = "cloudbuild.yaml"
  tags     = ["managed by terraform"]
}

#
# golang
#
resource "google_cloudbuild_trigger" "push_golang_base_image" {
  name = "push-golang-base-image"
  github {
    owner = "devopsui"
    name  = "golang"
    push {
      branch = "^main$"
    }
  }
  filename = "cloudbuild.yaml"
  tags     = ["managed by terraform"]
}

#
# node
#
resource "google_cloudbuild_trigger" "push_node_base_image" {
  name = "push-node-base-image"
  github {
    owner = "devopsui"
    name  = "node"
    push {
      branch = "^main$"
    }
  }
  filename = "cloudbuild.yaml"
  tags     = ["managed by terraform"]
}

#
# yq
#
resource "google_cloudbuild_trigger" "push_yq_base_image" {
  name = "push-yq-base-image"
  github {
    owner = "devopsui"
    name  = "yq"
    push {
      branch = "^main$"
    }
  }
  filename = "cloudbuild.yaml"
  tags     = ["managed by terraform"]
}

#
# builder-web
#
resource "google_cloudbuild_trigger" "deploy_builder_web" {
  name = "deploy-builder-web"
  github {
    owner = "devopsui"
    name  = "builder-web"
    push {
      tag    = var.env == "prod" ? "^production-v\\d+\\.\\d+\\.\\d+$" : null
      branch = var.env == "dev" ? "^main$" : null
    }
  }
  substitutions = {
    _ENV                          = var.env
    _FIREBASE_API_KEY             = var.firebase_api_key
    _FIREBASE_APP_ID              = var.firebase_app_id
    _FIREBASE_AUTH_DOMAIN         = var.firebase_auth_domain
    _FIREBASE_BUILDER_URL         = var.builder_api_url
    _FIREBASE_GITHUB_CLIENT_ID    = var.github_client_id
    _FIREBASE_MESSAGING_SENDER_ID = var.firebase_messaging_sender_id
    _FIREBASE_REGISTRY_URL        = var.registry_api_url
    _FIREBASE_STORAGE_BUCKET      = var.firebase_storage_bucket
  }
  filename = "cloudbuild.main.yaml"
  tags     = ["managed by terraform"]
}

resource "google_cloudbuild_trigger" "build_builder_web" {
  count = var.env == "prod" ? 0 : 1
  name  = "build-builder-web"
  github {
    owner = "devopsui"
    name  = "builder-web"
    pull_request {
      branch = ".*"
    }
  }
  substitutions = {
    _ENV                          = var.env
    _FIREBASE_API_KEY             = var.firebase_api_key
    _FIREBASE_APP_ID              = var.firebase_app_id
    _FIREBASE_AUTH_DOMAIN         = var.firebase_auth_domain
    _FIREBASE_BUILDER_URL         = var.builder_api_url
    _FIREBASE_GITHUB_CLIENT_ID    = var.github_client_id
    _FIREBASE_MESSAGING_SENDER_ID = var.firebase_messaging_sender_id
    _FIREBASE_REGISTRY_URL        = var.registry_api_url
    _FIREBASE_STORAGE_BUCKET      = var.firebase_storage_bucket
  }
  filename = "cloudbuild.pr.yaml"
  tags     = ["managed by terraform"]
}

#
# builder-api
#
resource "google_cloudbuild_trigger" "deploy_builder_api" {
  name = "deploy-builder-api"
  github {
    owner = "devopsui"
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
  tags     = ["managed by terraform"]
}

resource "google_cloudbuild_trigger" "build_builder_api" {
  count = var.env == "prod" ? 0 : 1
  name  = "build-builder-api"
  github {
    owner = "devopsui"
    name  = "builder-api"
    pull_request {
      branch = ".*"
    }
  }
  filename = "cloudbuild.pr.yaml"
  tags     = ["managed by terraform"]
}

#
# registry-api
#
resource "google_cloudbuild_trigger" "deploy_registry_api" {
  name = "deploy-registry-api"
  github {
    owner = "devopsui"
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
  tags     = ["managed by terraform"]
}

resource "google_cloudbuild_trigger" "build_registry_api" {
  count = var.env == "prod" ? 0 : 1
  name  = "build-registry-api"
  github {
    owner = "devopsui"
    name  = "registry-api"
    pull_request {
      branch = ".*"
    }
  }
  filename = "cloudbuild.pr.yaml"
  tags     = ["managed by terraform"]
}

#
# registry-etl
#
resource "google_cloudbuild_trigger" "deploy_registry_etl" {
  name = "deploy-registry-etl"
  github {
    owner = "devopsui"
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
  tags     = ["managed by terraform"]
}

resource "google_cloudbuild_trigger" "build_registry_etl" {
  count = var.env == "prod" ? 0 : 1
  name  = "build-registry-etl"
  github {
    owner = "devopsui"
    name  = "registry-etl"
    pull_request {
      branch = ".*"
    }
  }
  filename = "cloudbuild.pr.yaml"
  tags     = ["managed by terraform"]
}
