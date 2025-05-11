# modules/bigquery/outputs.tf
output "dataset_id" {
  description = "BigQuery dataset ID"
  value       = google_bigquery_dataset.dataset.dataset_id
}

output "dataset_full_id" {
  description = "Full qualified ID of the dataset"
  value       = google_bigquery_dataset.dataset.id
}