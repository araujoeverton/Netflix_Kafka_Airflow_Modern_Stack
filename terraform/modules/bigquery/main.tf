# modules/bigquery/main.tf
resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = "data_warehouse_${var.environment}"
  friendly_name               = "Data Warehouse ${var.environment}"
  description                 = "Dataset for data warehouse in ${var.environment} environment"
  location                    = var.region
  default_table_expiration_ms = null  # No expiration
  project                     = var.project_id
  
  labels = var.labels
  
  access {
    role          = "OWNER"
    special_group = "projectOwners"
  }
  
  access {
    role          = "READER"
    special_group = "projectReaders"
  }
  
  access {
    role          = "WRITER"
    special_group = "projectWriters"
  }
}

resource "google_bigquery_table" "example_table" {
  dataset_id          = google_bigquery_dataset.dataset.dataset_id
  table_id            = "example_table"
  description         = "Example table for demonstration"
  deletion_protection = false  # Set to true in production
  project             = var.project_id
  
  labels = var.labels
  
  schema = jsonencode([
    {
      "name": "id",
      "type": "STRING",
      "mode": "REQUIRED",
      "description": "ID of the record"
    },
    {
      "name": "created_at",
      "type": "TIMESTAMP",
      "mode": "REQUIRED",
      "description": "Timestamp when the record was created"
    },
    {
      "name": "data",
      "type": "JSON",
      "mode": "NULLABLE",
      "description": "Payload data"
    }
  ])
}