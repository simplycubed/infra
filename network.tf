module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 3.0"

  project_id   = var.project_id
  network_name = "gke"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "gke"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = var.region
    },
  ]

  secondary_ranges = {
    gke = [
      {
        range_name    = "pod-ip-ranges"
        ip_cidr_range = "10.60.0.0/14"
      },
      {
        range_name    = "service-ip-ranges"
        ip_cidr_range = "10.64.0.0/20"
      }
    ]
  }
}

resource "google_compute_global_address" "global_address" {
  count = length(local.dns)
  name  = local.dns[count.index]
}

locals {
  dns = [
    "prometheus",
    "grafana",
    "alert-manager",
    "argo-cd",
    "builder-api",
    "source-graph",
    "registry-api"
  ]
}

resource "google_compute_global_address" "private_ip_address" {
  provider      = google-beta
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = module.vpc.network_self_link
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider                = google-beta
  network                 = module.vpc.network_self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_compute_router" "router" {
  project = var.project_id
  name    = "nat-router"
  network = module.vpc.network_name
  region  = var.region
}

module "cloud-nat" {
  source                             = "terraform-google-modules/cloud-nat/google"
  version                            = "~> 2.0.0"
  project_id                         = var.project_id
  region                             = var.region
  router                             = google_compute_router.router.name
  name                               = "nat-config"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
