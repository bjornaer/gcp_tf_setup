resource "google_cloudfunctions_function" "backupFunction" {
  name                  = "backup"
  description           = "Performs a backup of the specified database in the db-backups bucket"
  runtime               = "nodejs10"
  project               = var.project_id
  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.db-backups.name
  source_archive_object = google_storage_bucket_object.archive.name
  trigger_http          = true
  entry_point           = "backup"
  environment_variables = {
    PROJECT_ID        = var.project_id,
    DB_INSTANCE_NAME  = google_sql_database_instance.main_primary.name,
    BUCKET_NAME       = google_storage_bucket.db-backups.name
    DB_NAME_TO_EXPORT = google_sql_database.main.name
  }
}
