resource "azurerm_resource_group" "woensel-acc" {
  name     = "woensel-acc-resourcegroup"
  location = "West Europe"
}

resource "azurerm_service_plan" "woensel-acc" {
  name                = "woensel-acc-serviceplan"
  location            = azurerm_resource_group.woensel-acc.location
  resource_group_name = azurerm_resource_group.woensel-acc.name
  os_type             = "Windows"
  sku_name            = "S1"
 
  }


resource "azurerm_windows_web_app" "woensel-acc" {
  name                = "woensel-acc-app-service"
  location            = azurerm_resource_group.woensel-acc.location
  resource_group_name = azurerm_resource_group.woensel-acc.name
  service_plan_id = azurerm_service_plan.woensel-acc.id
  site_config {
    
  }
}