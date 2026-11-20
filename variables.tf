variable "project_id" {
  description = "The GCP project ID where all resources will be deployed"
  type        = string
}

variable "region" {
  description = "The GCP region for resource deployment"
  type        = string
  default     = "us-central1"
}

variable "bucket_name" {
  description = "Globally unique name for the Cloud Storage bucket that holds sample CSV files"
  type        = string
}

variable "environment" {
  description = "Environment label applied to all resources (e.g., lab, dev, staging)"
  type        = string
  default     = "lab"

  validation {
    condition     = contains(["lab", "dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: lab, dev, staging, prod."
  }
}
