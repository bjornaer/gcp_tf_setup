resource "google_compute_network" "vpc" {
  name                    = var.name
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = true
}

# We don’t specify the exact address range. 
# Google will select the range for us. 
# We only need to specify how many addresses we want. 
# A prefix length of 20 will create around four thousand IP addresses. 
resource "google_compute_global_address" "private_ip_block" {
  name          = "private-ip-block"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  ip_version    = "IPV4"
  prefix_length = 20
  network       = google_compute_network.vpc.self_link
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_block.name]
}

# Enable connecting through ssh - come back later
# resource "google_compute_firewall" "allow_ssh" {
#   name      = "allow-ssh"
#   network   = google_compute_network.vpc.name
#   direction = "INGRESS"
#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }
#   target_tags = ["ssh-enabled"]
# }


