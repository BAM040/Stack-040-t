#refer to a resource group
data "azurerm_resource_group" "lets-go" {
    name = "letsgo"
}

resource "azurerm_virtual_network" "lets-go" {
  name                = "lets-go-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.lets-go.location
  resource_group_name = azurerm_resource_group.lets-go.name
}

resource "azurerm_subnet" "lets-go" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.lets-go.name
  virtual_network_name = azurerm_virtual_network.lets-go.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "lets-go" {
  name                = "lets-go-nic"
  location            = azurerm_resource_group.lets-go.location
  resource_group_name = azurerm_resource_group.lets-go.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.lets-go.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "lets-go" {
  name                = "windowstest"
  resource_group_name = azurerm_resource_group.lets-go.name
  location            = azurerm_resource_group.lets-go.location
  size                = "Standard_B1s"
  admin_username      = "Gaber"
  admin_password      = "Owkeejdann_040"
  network_interface_ids = [
    azurerm_network_interface.lets-go.id,
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