data "azurerm_subscription" "current" {}

resource "hcp_hvn" "hvn" {
  hvn_id         = var.deployment_id
  cloud_provider = "azure"
  region         = var.region
  cidr_block     = var.cidr_block
}

module "hcp_peering" {
  source  = "hashicorp/hcp-consul/azurerm"
  version = "~> 0.1.0"

  tenant_id            = data.azurerm_subscription.current.tenant_id
  subscription_id      = data.azurerm_subscription.current.subscription_id
  hvn                  = hcp_hvn.hvn
  vnet_rg              = var.rg_name
  vnet_id              = var.vnet_id
  subnet_ids           = var.subnet_ids
  prefix               = var.deployment_id
  security_group_names = [var.nsg_name]
}