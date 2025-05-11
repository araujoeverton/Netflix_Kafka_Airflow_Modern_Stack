# modules/compute/outputs.tf
output "airflow_vm_ip" {
  description = "Public IP of the Airflow VM"
  value       = google_compute_instance.airflow_dbt_vm.network_interface[0].access_config[0].nat_ip
}

output "service_account_email" {
  description = "Email of the service account"
  value       = google_service_account.airflow_dbt_sa.email
}
