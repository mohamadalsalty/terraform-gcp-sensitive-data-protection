output "bucket_name" {
  description = "Name of the Cloud Storage bucket for sensitive data files"
  value       = google_storage_bucket.sensitive_data.name
}

output "bucket_url" {
  description = "gsutil URL of the sensitive data bucket"
  value       = google_storage_bucket.sensitive_data.url
}

output "bucket_location" {
  description = "GCP region where the bucket is located"
  value       = google_storage_bucket.sensitive_data.location
}

output "service_account_email" {
  description = "Email address of the DLP inspection service account"
  value       = google_service_account.dlp_sa.email
}

output "project_id" {
  description = "GCP project ID where all resources are deployed"
  value       = var.project_id
}

output "region" {
  description = "GCP region for this deployment"
  value       = var.region
}

output "bigquery_dataset" {
  description = "BigQuery dataset where DLP findings are stored"
  value       = google_bigquery_dataset.dlp_findings.dataset_id
}

output "findings_table" {
  description = "Full BigQuery table path for querying findings"
  value       = "${var.project_id}.${google_bigquery_dataset.dlp_findings.dataset_id}.results"
}
