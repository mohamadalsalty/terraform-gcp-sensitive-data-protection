resource "google_service_account" "dlp_sa" {
  account_id   = "dlp-inspection-sa"
  display_name = "DLP Inspection Service Account"
  description  = "Least-privilege SA for Sensitive Data Protection inspection and de-identification jobs"
  project      = var.project_id

  depends_on = [google_project_service.iam]
}

# Read access to the bucket so the SA can feed files into inspection jobs
resource "google_storage_bucket_iam_member" "dlp_sa_object_viewer" {
  bucket = google_storage_bucket.sensitive_data.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.dlp_sa.email}"
}

# Write access so the SA can store de-identified output back into the bucket
resource "google_storage_bucket_iam_member" "dlp_sa_object_creator" {
  bucket = google_storage_bucket.sensitive_data.name
  role   = "roles/storage.objectCreator"
  member = "serviceAccount:${google_service_account.dlp_sa.email}"
}

# Grants permission to create and manage DLP inspection/de-identification jobs and templates
resource "google_project_iam_member" "dlp_sa_dlp_user" {
  project = var.project_id
  role    = "roles/dlp.user"
  member  = "serviceAccount:${google_service_account.dlp_sa.email}"
}
