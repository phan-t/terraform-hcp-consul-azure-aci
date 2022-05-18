terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = ">= 0.23.1"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "hcp" {
  client_id     = var.hcp_client_id
  client_secret = var.hcp_client_secret
}

# provider "consul" {
#   address    = hcp_consul_cluster.main.consul_public_endpoint_url
#   datacenter = hcp_consul_cluster.main.datacenter
#   token      = hcp_consul_cluster_root_token.token.secret_id
# }