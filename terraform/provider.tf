# provider.tf
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.83.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.83.0"
    }
    confluent = {
      source  = "confluentinc/confluent"
      version = "~> 1.42.0"
    }
  }
  backend "gcs" {
    bucket = "netflix-terraform-state-bucket"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}