# main.tf
locals {
  project_name = "netflix-modern-stack-plataform"
  labels = {
    environment = var.environment
    managed_by  = "terraform"
    project     = local.project_name
  }
}

module "networking" {
  source       = "./modules/networking"
  project_id   = var.project_id
  network_name = var.network_name
  region       = var.region
  environment  = var.environment
  labels       = local.labels
}

module "kafka" {
  source      = "./modules/kafka"
  project_id  = var.project_id
  environment = var.environment
  region      = var.region
  labels      = local.labels
  depends_on  = [module.networking]
}

module "compute" {
  source         = "./modules/compute"
  project_id     = var.project_id
  environment    = var.environment
  region         = var.region
  zone           = var.zone
  network_id     = module.networking.network_id
  subnet_id      = module.networking.subnet_id
  kafka_brokers  = module.kafka.bootstrap_servers
  labels         = local.labels
}

module "bigquery" {
  source      = "./modules/bigquery"
  project_id  = var.project_id
  environment = var.environment
  region      = var.region
  labels      = local.labels
}

module "iam" {
  source      = "./modules/iam"
  project_id  = var.project_id
  environment = var.environment
  compute_sa  = module.compute.service_account_email
  labels      = local.labels
}