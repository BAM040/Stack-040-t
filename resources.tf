variable "resource_group_name" {
    type = string
    description = "please enter rg name"
  
}

resource "azurerm_resource_group" "fw040" {
  name     = var.resource_group_name
  location = "West Europe"
}

resource "azurerm_virtual_network" "fw040" {
  name                = "azurefirewallvnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.fw040.location
  resource_group_name = azurerm_resource_group.fw040.name
}

resource "azurerm_subnet" "fw040" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.fw040.name
  virtual_network_name = azurerm_virtual_network.fw040.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "fw040" {
  name                = "testpip"
  location            = azurerm_resource_group.fw040.location
  resource_group_name = azurerm_resource_group.fw040.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "fw040" {
  name                = "testfirewall"
  location            = azurerm_resource_group.fw040.location
  resource_group_name = azurerm_resource_group.fw040.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.fw040.id
    public_ip_address_id = azurerm_public_ip.fw040.id
  }
}