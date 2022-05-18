resource "azurerm_route_table" "rt" {
  name                = "${var.deployment_id}-rt"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.deployment_id}-nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

module "vnet" {
  source              = "Azure/vnet/azurerm"
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.vnet_cidrs
  subnet_prefixes     = values(var.vnet_subnets)
  subnet_names        = keys(var.vnet_subnets)
  vnet_name           = "${var.deployment_id}-vnet"

  subnet_delegation = {
    aci-snet = {
      "Microsoft.ContainerInstance/containerGroups" = {
        service_name = "Microsoft.ContainerInstance/containerGroups"
        service_actions = [
          "Microsoft.Network/virtualNetworks/subnets/action",
        ]
      }
    }
  }

  # Every subnet will share a single route table
  route_tables_ids = { for i, subnet in keys(var.vnet_subnets) : subnet => azurerm_route_table.rt.id }

  # Every subnet will share a single network security group
  nsg_ids = { for i, subnet in keys(var.vnet_subnets) : subnet => azurerm_network_security_group.nsg.id }

  depends_on = [azurerm_resource_group.rg]
}

resource "azurerm_network_profile" "nprf" {
  name                = "${var.deployment_id}-nprf"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  container_network_interface {
    name = "containernic"

    ip_configuration {
      name      = "containeripconfig"
      subnet_id = module.vnet.vnet_subnets[0]

    }
  }
}

resource "azurerm_nat_gateway" "ng" {
  name                    = "${var.deployment_id}-ng"
  location                = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name
  sku_name                = "Standard"
}

resource "azurerm_public_ip" "pip" {
  name                = "${var.deployment_id}-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip_prefix" "ippre" {
  name                = "${var.deployment_id}-ippre"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  prefix_length       = 30
}

resource "azurerm_nat_gateway_public_ip_association" "pip" {
  nat_gateway_id       = azurerm_nat_gateway.ng.id
  public_ip_address_id = azurerm_public_ip.pip.id
}

resource "azurerm_nat_gateway_public_ip_prefix_association" "ippre" {
  nat_gateway_id      = azurerm_nat_gateway.ng.id
  public_ip_prefix_id = azurerm_public_ip_prefix.ippre.id
}

resource "azurerm_subnet_nat_gateway_association" "snetng" {
  subnet_id      = module.vnet.vnet_subnets[0]
  nat_gateway_id = azurerm_nat_gateway.ng.id
}