resource "google_storage_bucket_object" "clientes" {
  name   = "samples/clientes.csv"
  bucket = google_storage_bucket.sensitive_data.name
  source = "${path.module}/samples/clientes.csv"
}

resource "google_storage_bucket_object" "funcionarios" {
  name   = "samples/funcionarios.csv"
  bucket = google_storage_bucket.sensitive_data.name
  source = "${path.module}/samples/funcionarios.csv"
}

resource "google_storage_bucket_object" "leads" {
  name   = "samples/leads.csv"
  bucket = google_storage_bucket.sensitive_data.name
  source = "${path.module}/samples/leads.csv"
}
