resource "google_app_engine_application" "app_engine" {
  project     = var.project_id
  location_id = "europe-west"
}

resource "google_cloud_scheduler_job" "backupJob" {
  project     = var.project_id
  region      = var.gcp_region_1
  name        = "backup-job"
  description = "Create a backup of the database"
  schedule    = "0 4 * * *"
  time_zone   = "Europe/Paris"
  http_target {
    http_method = "POST"
    uri         = google_cloudfunctions_function.backupFunction.https_trigger_url
  }
}
