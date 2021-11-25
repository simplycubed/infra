resource "random_id" "db_name_suffix" {
  byte_length = 3
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_sql_database_instance" "instance" {
  provider            = google-beta
  database_version    = "POSTGRES_13"
  name                = "private-instance-${random_id.db_name_suffix.hex}"
  region              = var.region
  deletion_protection = var.db_deletion_protection
  settings {
    tier = var.db_machine_type
    ip_configuration {
      ipv4_enabled    = false
      private_network = module.vpc.network_self_link
      require_ssl     = true
    }
  }
  depends_on = [google_service_networking_connection.private_vpc_connection]
}


