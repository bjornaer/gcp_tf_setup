resource "google_monitoring_alert_policy" "alert_policy" {
  project      = var.project_id
  display_name = "Alert Policy"
  combiner     = "OR"
  conditions {
    display_name = "Disk Usage"
    condition_threshold {
      # the bellow filter I am not 100% because the google docs page was down when I tried to refer to it, so might be wrong.
      filter          = "metric.type=\"compute.googleapis.com/instance/disk/percent_used\" AND resource.type=\"cloudsql_instance_database\""
      duration        = "60s"
      threshold_value = 0.85
      comparison      = "COMPARISON_GT"
      aggregations {
        alignment_period     = "60s"
        cross_series_reducer = "REDUCE_MEAN"
        per_series_aligner   = "ALIGN_MAX"
        group_by_fields = [
          "resource.label.project_id",
          "resource.label.database",
          "resource.label.resource_id"
        ]
      }
    }
  }
  conditions {
    display_name = "CPU Usage"
    condition_threshold {
      filter          = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.type=\"cloudsql_instance_database\""
      duration        = "60s"
      threshold_value = 0.9
      comparison      = "COMPARISON_GT"
      aggregations {
        alignment_period     = "60s"
        cross_series_reducer = "REDUCE_MEAN"
        per_series_aligner   = "ALIGN_MAX"
        group_by_fields = [
          "resource.label.project_id",
          "resource.label.database",
          "resource.label.resource_id"
        ]
      }
    }
  }
}
