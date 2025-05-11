# modules/compute/main.tf
resource "google_service_account" "airflow_dbt_sa" {
  account_id   = "airflow-dbt-sa-${var.environment}"
  display_name = "Airflow and dbt Service Account"
  project      = var.project_id
}

resource "google_compute_instance" "airflow_dbt_vm" {
  name         = "airflow-dbt-vm-${var.environment}"
  machine_type = "e2-standard-4"
  zone         = var.zone
  project      = var.project_id
  
  tags = ["airflow-dbt", var.environment]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 100  # 100 GB disk
    }
  }

  network_interface {
    subnetwork = var.subnet_id
    
    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    ssh-keys = "admin:${file(var.ssh_public_key_path)}"
  }

  metadata_startup_script = templatefile("${path.module}/scripts/startup-script.sh", {
    kafka_brokers = var.kafka_brokers
    project_id    = var.project_id
    environment   = var.environment
  })

  service_account {
    email  = google_service_account.airflow_dbt_sa.email
    scopes = ["cloud-platform"]
  }

  labels = var.labels
  
  allow_stopping_for_update = true
}