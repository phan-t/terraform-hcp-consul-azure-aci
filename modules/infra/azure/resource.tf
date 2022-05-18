resource "azurerm_resource_group" "rg" {
  name     = "${var.deployment_id}-rg"
  location = var.region
}

