# resource "local_file" "consul-ca" {
#   content = base64decode(var.consul_ca)
#   filename = "${path.module}/ca.pem"
# }

# resource "local_file" "consul-client-config" {
#   content = templatefile("${path.root}/templates/consul-client-config.json", {
#     deployment_id       = var.deployment_id
#     agent_token         = var.consul_root_token
#     gossip_encrypt_key  = var.consul_gossip_encrypt_key
#     server_private_fqdn = trimprefix(var.consul_private_address, "https://")
#     })
#   filename = "${path.module}/consul-client-config.json"
# }

locals {
  consul_client_config = templatefile("${path.root}/templates/consul-client-config.json", {
    deployment_id       = var.deployment_id
    agent_token         = var.consul_root_token
    gossip_encrypt_key  = var.consul_gossip_encrypt_key
    server_private_fqdn = trimprefix(var.consul_private_address, "https://")
    })
}

resource "azurerm_container_group" "cg" {
  name                = "${var.deployment_id}-cg"
  location            = var.rg_location
  resource_group_name = var.rg_name
  ip_address_type     = "Private"
  network_profile_id  = var.nprf_id
  os_type             = "Linux"

  container {
    name   = "hello-world"
    image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  container {
    name   = "sidecar"
    image  = "consul:1.12"
    cpu    = "0.5"
    memory = "1.5"

    environment_variables = {
      CONSUL_LOCAL_CONFIG = local.consul_client_config
    }

    volume {
      name = "ca"
      mount_path = "/tmp"
      read_only = false
      secret = {
          "ca.pem" = var.consul_ca
        }
    }

    volume {
      name = "service"
      mount_path = "/consul/config"
      read_only = false
      secret = {
          "service.json" = filebase64("${path.root}/templates/consul-service-aci-helloworld.json")
        }
    }
  }
  timeouts {
      create = "5m"
      update = "5m"
  }
}