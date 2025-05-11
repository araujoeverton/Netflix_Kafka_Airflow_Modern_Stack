# modules/kafka/outputs.tf
output "bootstrap_servers" {
  description = "Kafka bootstrap servers"
  value       = confluent_kafka_cluster.cluster.bootstrap_endpoint
}

output "kafka_api_key" {
  description = "Kafka API Key"
  value       = confluent_api_key.app-manager-kafka-api-key.id
  sensitive   = true
}

output "kafka_api_secret" {
  description = "Kafka API Secret"
  value       = confluent_api_key.app-manager-kafka-api-key.secret
  sensitive   = true
}
