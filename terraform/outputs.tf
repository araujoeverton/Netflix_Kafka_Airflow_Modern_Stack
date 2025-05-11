# outputs.tf
output "kafka_bootstrap_servers" {
  description = "Kafka bootstrap servers"
  value       = module.kafka.bootstrap_servers
}

output "airflow_vm_ip" {
  description = "Public IP of the Airflow VM"
  value       = module.compute.airflow_vm_ip
}

output "bigquery_dataset_id" {
  description = "BigQuery dataset ID"
  value       = module.bigquery.dataset_id
}