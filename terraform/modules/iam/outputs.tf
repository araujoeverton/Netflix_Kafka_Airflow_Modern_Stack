# modules/iam/outputs.tf
output "roles_assigned" {
  description = "List of roles assigned"
  value = [
    "roles/bigquery.dataEditor",
    "roles/bigquery.user",
    "roles/storage.admin"
  ]
}