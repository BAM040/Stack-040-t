resource "azurerm_resource_group" "lets-go" {
    name = "letsgo"
    location = "west europe"

  
}

resource "azurerm_public_ip" "publiekelijk" {
    name = "dit"
    resource_group_name = azurerm_resource_group.lets-go
    location = location.azurerm_resource_group
    allocation_method = "static"
  
}