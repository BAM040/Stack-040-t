terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.22.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "03e8ec86-4b51-496c-956a-d7939d89db67"
  client_id = "9bf33daf-de3c-4750-99bc-4cc73db4b9b7"
  client_secret = "dNY8Q~vZJ~0NQcPWAdJisGXUFX3L8TJNBKI3RcTj"
  tenant_id = "bae34d96-5e48-4672-9fa4-291181155242"
  features {
    
  }
}
