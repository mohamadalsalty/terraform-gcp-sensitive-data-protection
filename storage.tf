resource "google_storage_bucket" "sensitive_data" {
  name     = var.bucket_name
  location = var.region
  project  = var.project_id

  # Allows Terraform to delete the bucket even if it contains objects (lab convenience)
  force_destroy = true

  # Uniform bucket-level access disables per-object ACLs, centralising access control in IAM
  uniform_bucket_level_access = true

  # Prevents any public access regardless of IAM bindings
  public_access_prevention = "enforced"

  versioning {
    enabled = false
  }

  labels = {
    environment = var.environment
    purpose     = "sensitive-data-lab"
    managed-by  = "terraform"
  }

  depends_on = [google_project_service.storage]
}
