terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">=3.0"
    }
  }
  backend "azurerm" {
        resource_group_name  = "tfstate"
        storage_account_name = "tfstatef8sti"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
        subscription_id = "03e8ec86-4b51-496c-956a-d7939d89db67"
    }

}

provider "azurerm" {
  skip_provider_registration = true
  subscription_id = "03e8ec86-4b51-496c-956a-d7939d89db67"
  features {
    
  }
}
