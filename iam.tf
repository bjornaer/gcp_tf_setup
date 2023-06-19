# enable DB write access to bucket
resource "google_storage_bucket_iam_member" "editor" {
  bucket = google_storage_bucket.db-backups.name
  role   = "roles/storage.objectCreator"
  member = "serviceAccount:${google_sql_database_instance.main_primary.service_account_email_address}"
}
