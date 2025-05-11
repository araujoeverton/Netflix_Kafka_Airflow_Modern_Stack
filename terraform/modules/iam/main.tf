# modules/iam/main.tf
resource "google_project_iam_member" "compute_sa_bigquery_editor" {
  project = var.project_id
  role    = "roles/bigquery.dataEditor"
  member  = "serviceAccount:${var.compute_sa}"
}

resource "google_project_iam_member" "compute_sa_bigquery_user" {
  project = var.project_id
  role    = "roles/bigquery.user"
  member  = "serviceAccount:${var.compute_sa}"
}

resource "google_project_iam_member" "compute_sa_storage_admin" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${var.compute_sa}"
}