resource "hcp_consul_cluster" "dev" {
  cluster_id      = var.deployment_id
  hvn_id          = var.hvn_id
  public_endpoint = true
  tier            = var.tier
}

resource "hcp_consul_cluster_root_token" "dev-token" {
  cluster_id      = hcp_consul_cluster.dev.id
}

locals {
  config_data  = jsondecode(base64decode(hcp_consul_cluster.dev.consul_config_file))
  gossip_encrypt_key  = local.config_data.encrypt
}

