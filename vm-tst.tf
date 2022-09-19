resource "azurerm_resource_group" "vm-tst" {
  name     = "vm-tst-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vm-tst" {
  name                = "vm-tst-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.vm-tst.location
  resource_group_name = azurerm_resource_group.vm-tst.name
}

resource "azurerm_subnet" "vm-tst" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.vm-tst.name
  virtual_network_name = azurerm_virtual_network.vm-tst.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "vm-tst" {
  name                = "vm-tst-nic"
  location            = azurerm_resource_group.vm-tst.location
  resource_group_name = azurerm_resource_group.vm-tst.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm-tst.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm-tst" {
  name                = "vm-tst-machine"
  resource_group_name = azurerm_resource_group.vm-tst.name
  location            = azurerm_resource_group.vm-tst.location
  size                = "Standard_B1s"
  admin_username      = "Gaber"
  admin_password      = "Owkeejdann_040"
  network_interface_ids = [
    azurerm_network_interface.vm-tst.id,
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