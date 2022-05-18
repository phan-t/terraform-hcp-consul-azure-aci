locals {
  deployment_id = lower("${var.deployment_name}-${random_string.suffix.result}")
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "infra-azure" {
  source  = "./modules/infra/azure"
  
  region                = var.azure_region
  deployment_id         = local.deployment_id
}

module "hvn" {
  source  = "./modules/hcp/hvn"
  
  region        = var.hcp_hvn_region
  deployment_id = local.deployment_id
  cidr_block    = var.hcp_hvn_cidr_block
  rg_name       = module.infra-azure.rg_name
  vnet_id       = module.infra-azure.vnet_id
  subnet_ids    = module.infra-azure.subnet_ids
  nsg_name      = module.infra-azure.nsg_name
}

module "consul" {
  source = "./modules/hcp/consul"

  region        = var.hcp_hvn_region
  deployment_id = local.deployment_id
  hvn_id        = module.hvn.hvn_id
  tier          = var.tier
}

module "aci-helloworld" {
  source = "./modules/aci-helloworld/azure"

  deployment_id             = local.deployment_id
  consul_ca                 = module.consul.ca
  consul_root_token         = module.consul.root_token
  consul_gossip_encrypt_key = module.consul.gossip_encrypt_key
  consul_private_address    = module.consul.private_address
  rg_location               = module.infra-azure.rg_location
  rg_name                   = module.infra-azure.rg_name
  nprf_id                   = module.infra-azure.nprf_id
}