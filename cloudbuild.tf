#
# firebase
#
resource "google_cloudbuild_trigger" "push_firebase_base_image" {
  name = "push-firebase-base-image"
  github {
    owner = "simplycubed"
    name  = "firebase"
    push {
      branch = "^main$"
    }
  }
  filename = "cloudbuild.yaml"
  tags     = ["managed by terraform"]
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
  tags     = ["managed by terraform"]
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
  tags     = ["managed by terraform"]
}

#
# pspbuilder
#
resource "google_cloudbuild_trigger" "push_pspbuilder_base_image" {
  name = "push-pspbuilder-base-image"
  github {
    owner = "simplycubed"
    name  = "pspbuilder"
    push {
      branch = "^main$"
    }
  }
  filename = "cloudbuild.yaml"
  tags     = ["managed by terraform"]
}

#
# Security Policies
#
resource "google_cloudbuild_trigger" "deploy_security_policies" {
  name = "deploy-security-policies"
  github {
    owner = "simplycubed"
    name  = "security-policies"
    push {
      branch = var.env == "prod" ? "^main$" : "^dev$"
    }
  }
  substitutions = {
    _ENV = var.env
  }
  filename = "cloudbuild.main.yaml"
  tags     = ["managed by terraform"]
}

resource "google_cloudbuild_trigger" "build_security_policies" {
  count = var.env == "prod" ? 0 : 1
  name  = "build-security-policies"
  github {
    owner = "simplycubed"
    name  = "security-policies"
    pull_request {
      branch = ".*"
    }
  }
  substitutions = {
    _ENV = var.env
  }
  filename = "cloudbuild.pr.yaml"
  tags     = ["managed by terraform"]
}

#
# web
#
resource "google_cloudbuild_trigger" "deploy_web" {
  name = "deploy-web"
  github {
    owner = "simplycubed"
    name  = "web"
    push {
      branch = var.env == "prod" ? "^main$" : "^dev$"
    }
  }
  substitutions = {
    _ENV                          = var.env
    _FIREBASE_API_KEY             = var.firebase_api_key
    _FIREBASE_APP_ID              = var.firebase_app_id
    _FIREBASE_AUTH_DOMAIN         = var.firebase_auth_domain
    _FIREBASE_MEASUREMENT_ID      = var.firebase_measurement_id
    _FIREBASE_MESSAGING_SENDER_ID = var.firebase_messaging_sender_id
    _FIREBASE_STORAGE_BUCKET      = var.firebase_storage_bucket
  }
  # TODO: Rename cloudbuild.yaml to cloudbuild.main.yaml
  filename = "cloudbuild.yaml"
  tags     = ["managed by terraform"]
}

resource "google_cloudbuild_trigger" "build_web" {
  count = var.env == "prod" ? 0 : 1
  name  = "build-web"
  github {
    owner = "simplycubed"
    name  = "web"
    pull_request {
      branch = ".*"
    }
  }
  substitutions = {
    _ENV                          = var.env
    _FIREBASE_API_KEY             = var.firebase_api_key
    _FIREBASE_APP_ID              = var.firebase_app_id
    _FIREBASE_AUTH_DOMAIN         = var.firebase_auth_domain
    _FIREBASE_MEASUREMENT_ID      = var.firebase_measurement_id
    _FIREBASE_MESSAGING_SENDER_ID = var.firebase_messaging_sender_id
    _FIREBASE_STORAGE_BUCKET      = var.firebase_storage_bucket
  }
  filename = "cloudbuild.pr.yaml"
  tags     = ["managed by terraform"]
}
