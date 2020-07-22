provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x. 
    # If you are using version 1.x, the "features" block is not allowed.
    version = "2.5"
    features {}
}

terraform {
    backend "azurerm" {
    
    	resource_group_name		= "rg-aks-test"
		  storage_account_name	= "saaks"
	  	container_name			= "tfstate"
		  key						= "rg-aks-test.tfstate"
    
    }
}