data "archive_file" "backupZipFile" {
  type        = "zip"
  output_path = "${path.module}/dbbackup/backup.zip"

  source {
    content  = file("${path.module}/dbbackup/index.js")
    filename = "index.js"
  }

  source {
    content  = file("${path.module}/dbbackup/package.json")
    filename = "package.json"
  }
}
