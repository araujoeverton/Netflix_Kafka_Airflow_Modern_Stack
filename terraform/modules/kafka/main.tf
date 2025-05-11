# modules/kafka/main.tf
resource "confluent_environment" "env" {
  display_name = "kafka-${var.environment}"
}

resource "confluent_kafka_cluster" "cluster" {
  display_name = "kafka-cluster-${var.environment}"
  availability = "SINGLE_ZONE"
  cloud        = "GCP"
  region       = var.region
  basic {}

  environment {
    id = confluent_environment.env.id
  }
}

resource "confluent_service_account" "app-manager" {
  display_name = "app-manager-${var.environment}"
  description  = "Service account for managing Kafka resources"
}

resource "confluent_role_binding" "app-manager-kafka-cluster-admin" {
  principal   = "User:${confluent_service_account.app-manager.id}"
  role_name   = "CloudClusterAdmin"
  crn_pattern = confluent_kafka_cluster.cluster.rbac_crn
}

resource "confluent_api_key" "app-manager-kafka-api-key" {
  display_name = "app-manager-kafka-api-key-${var.environment}"
  description  = "Kafka API Key that is owned by 'app-manager' service account"
  owner {
    id          = confluent_service_account.app-manager.id
    api_version = confluent_service_account.app-manager.api_version
    kind        = confluent_service_account.app-manager.kind
  }

  managed_resource {
    id          = confluent_kafka_cluster.cluster.id
    api_version = confluent_kafka_cluster.cluster.api_version
    kind        = confluent_kafka_cluster.cluster.kind

    environment {
      id = confluent_environment.env.id
    }
  }
}