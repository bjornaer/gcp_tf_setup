resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "random_id" "random_password" {
  byte_length = 8
}

resource "google_sql_database_instance" "main_primary" {
  name             = "main-primary-${random_id.db_name_suffix.hex}"
  region           = var.gcp_region_1
  database_version = "POSTGRES_13"
  depends_on       = [google_service_networking_connection.private_vpc_connection]
  settings {
    tier = "db-f1-micro"
    # The master instance is configured as “REGIONAL” so a standby is already in place.
    availability_type = "REGIONAL"
    disk_size         = 10 # 10 GB is the smallest disk size
    ip_configuration {
      ipv4_enabled    = false # this is to prevent the db from getting a public IP
      private_network = google_compute_network.vpc.self_link
    }
  }
}

resource "google_sql_user" "main" {
  depends_on = [
    google_sql_database_instance.main_primary
  ]
  name     = "main"
  instance = google_sql_database_instance.main_primary.name
  password = var.db_password != "" ? var.db_password : random_id.random_password
}

resource "google_sql_database" "main" {
  depends_on = [
    google_sql_user.main
  ]
  name     = "main"
  instance = google_sql_database_instance.main_primary.name
}

# Read Replica

# Since the instance above spawns with a standby,
# I wasn't sure I was supposed to create also a read replica
# In any case, here it is, just uncomment to add

# resource "google_sql_database_instance" "read_replica" {
#   name                 = "replica-${random_id.db_name_suffix.hex}"
#   master_instance_name = "${var.project_id}:${google_sql_database_instance.master.name}"
#   region               = var.gcp_region_1
#   database_version     = "POSTGRES_13"

#   replica_configuration {
#     failover_target = false
#   }

#   settings {
#     tier              = "db-f1-micro"
#     availability_type = "ZONAL"
#     disk_size         = "100"
#     backup_configuration {
#       enabled = false
#     }
#     ip_configuration {
#       ipv4_enabled    = true
#       private_network = "projects/${var.project_id}/global/networks/default"
#     }
#     location_preference {
#       zone = var.gcp_zone_1
#     }
#   }
# }
