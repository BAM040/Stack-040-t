resource "azurerm_resource_group" "woensel-tst" {
  name     = "woensel-tst-resourcegroup"
  location = "West Europe"
}

resource "azurerm_service_plan" "woensel-tst" {
  name                = "woensel-tst-serviceplan"
  location            = azurerm_resource_group.woensel-tst.location
  resource_group_name = azurerm_resource_group.woensel-tst.name
  os_type             = "Windows"
  sku_name            = "S1"
 
  }


resource "azurerm_windows_web_app" "woensel-tst" {
  name                = "woensel-tst-app-service"
  location            = azurerm_resource_group.woensel-tst.location
  resource_group_name = azurerm_resource_group.woensel-tst.name
  service_plan_id = azurerm_service_plan.woensel-tst.id
  site_config {
    
  }
}