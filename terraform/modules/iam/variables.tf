# modules/iam/variables.tf
variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
}

variable "compute_sa" {
  description = "Email of the compute service account"
  type        = string
}

variable "labels" {
  description = "Resource labels"
  type        = map(string)
}