# Create new storage bucket in the US multi-region
# with standard storage

resource "google_storage_bucket" "db-backups" {
  project       = var.project_id
  name          = "db-backups-${var.project_id}"
  location      = "EU"
  storage_class = "STANDARD"

  uniform_bucket_level_access = true

  lifecycle_rule {
    condition {
      age = "15" # days
    }
    action {
      type = "Delete"
    }
  }
}

# create our archive for backups
resource "google_storage_bucket_object" "archive" {
  name   = "cloudFunctions/backup-${lower(replace(base64encode(data.archive_file.backupZipFile.output_md5), "=", ""))}.zip"
  bucket = google_storage_bucket.db-backups.name
  # Source path is relative to where the module is used : to improve
  source     = data.archive_file.backupZipFile.output_path
  depends_on = [data.archive_file.backupZipFile]
}


