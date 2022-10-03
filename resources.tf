resource "azurerm_resource_group" "fw-040" {
  name     = "firewallgroup"
  location = "West Europe"
}

resource "azurerm_virtual_network" "fw-040" {
  name                = "azurefirewallvnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.fw-040.location
  resource_group_name = azurerm_resource_group.fw-040.name
}

resource "azurerm_subnet" "fw-040" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.fw-040.name
  virtual_network_name = azurerm_virtual_network.fw-040.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "fw-0402" {
  name                 = "Azurevmsubnet"
  resource_group_name  = azurerm_resource_group.fw-040.name
  virtual_network_name = azurerm_virtual_network.fw-040.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "fw-040" {
  name                = "testpip"
  location            = azurerm_resource_group.fw-040.location
  resource_group_name = azurerm_resource_group.fw-040.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "fw-040" {
  name                = "testfirewall"
  location            = azurerm_resource_group.fw-040.location
  resource_group_name = azurerm_resource_group.fw-040.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.fw-040.id
    public_ip_address_id = azurerm_public_ip.fw-040.id
  }
}

resource "azurerm_network_interface" "fw-040" {
  name                = "fw-040-nic"
  location            = azurerm_resource_group.fw-040.location
  resource_group_name = azurerm_resource_group.fw-040.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.fw-0402.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "fw-040" {
  name                = "firewall-vm"
  resource_group_name = azurerm_resource_group.fw-040.name
  location            = azurerm_resource_group.fw-040.location
  size                = "Standard_F2"
  admin_username      = "gaber"
  admin_password      = "Owkeejdann_040"
  network_interface_ids = [
    azurerm_network_interface.fw-040.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}
