provider "azurerm" {
    features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.7.0"
    }
  }

  backend azurerm{
    container_name       = "default"
    storage_account_name = ""
    resource_group_name  = ""
    key                  = "aks.tfstate"
  }
}