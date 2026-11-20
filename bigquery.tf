resource "google_bigquery_dataset" "dlp_findings" {
  dataset_id    = "dlp_findings"
  friendly_name = "DLP Findings"
  description   = "Stores Sensitive Data Protection inspection findings including matched values"
  location      = var.region
  project       = var.project_id

  labels = {
    environment = var.environment
    purpose     = "sensitive-data-lab"
    managed-by  = "terraform"
  }

  depends_on = [google_project_service.bigquery]
}

resource "google_bigquery_dataset_iam_member" "dlp_sa_bq_editor" {
  project    = var.project_id
  dataset_id = google_bigquery_dataset.dlp_findings.dataset_id
  role       = "roles/bigquery.dataEditor"
  member     = "serviceAccount:${google_service_account.dlp_sa.email}"
}

resource "google_project_iam_member" "dlp_sa_bq_job_user" {
  project = var.project_id
  role    = "roles/bigquery.jobUser"
  member  = "serviceAccount:${google_service_account.dlp_sa.email}"
}
