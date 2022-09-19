resource "azurerm_resource_group" "woensel-prd" {
  name     = "woensel-prd-resourcegroup"
  location = "West Europe"
}

resource "azurerm_service_plan" "woensel-prd" {
  name                = "woensel-prd-serviceplan"
  location            = azurerm_resource_group.woensel-prd.location
  resource_group_name = azurerm_resource_group.woensel-prd.name
  os_type             = "Windows"
  sku_name            = "S1"
 
  }


resource "azurerm_windows_web_app" "woensel-prd" {
  name                = "woensel-prd-app-service"
  location            = azurerm_resource_group.woensel-prd.location
  resource_group_name = azurerm_resource_group.woensel-prd.name
  service_plan_id = azurerm_service_plan.woensel-prd.id
  site_config {
    
  }
}