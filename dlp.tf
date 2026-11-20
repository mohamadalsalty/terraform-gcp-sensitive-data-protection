resource "google_data_loss_prevention_inspect_template" "pii" {
  parent       = "projects/${var.project_id}/locations/${var.region}"
  display_name = "SDP Lab - PII Inspect Template"
  description  = "Detects Brazilian CPF, email addresses, phone numbers and person names"

  inspect_config {
    include_quote = true

    info_types {
      name = "BRAZIL_CPF_NUMBER"
    }
    info_types {
      name = "EMAIL_ADDRESS"
    }
    info_types {
      name = "PHONE_NUMBER"
    }
    info_types {
      name = "PERSON_NAME"
    }
    info_types {
      name = "DATE_OF_BIRTH"
    }

    min_likelihood = "POSSIBLE"

    limits {
      max_findings_per_item    = 0
      max_findings_per_request = 0
    }
  }

  depends_on = [google_project_service.dlp]
}

resource "google_data_loss_prevention_job_trigger" "gcs_scan" {
  parent       = "projects/${var.project_id}/locations/${var.region}"
  display_name = "GCS Bucket PII Scanner"
  description  = "Scans the sensitive data bucket for PII on a daily schedule"
  status       = "HEALTHY"

  triggers {
    schedule {
      recurrence_period_duration = "86400s"
    }
  }

  inspect_job {
    inspect_template_name = google_data_loss_prevention_inspect_template.pii.id

    storage_config {
      cloud_storage_options {
        file_set {
          url = "gs://${google_storage_bucket.sensitive_data.name}/**"
        }
        file_types = ["CSV", "TEXT_FILE"]
      }
    }

    actions {
      save_findings {
        output_config {
          table {
            project_id = var.project_id
            dataset_id = google_bigquery_dataset.dlp_findings.dataset_id
            table_id   = "results"
          }
        }
      }
    }
  }

  depends_on = [google_project_service.dlp, google_bigquery_dataset.dlp_findings]
}
