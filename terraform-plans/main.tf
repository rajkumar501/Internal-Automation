provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x. 
    # If you are using version 1.x, the "features" block is not allowed.
    version = "~>2.0"
    features {}
}

terraform {
    backend "azurerm" {
    storage_account_name = "cs21003200097e7da8f"
    container_name       = "tfstate"
    key                  = "codelab.microsoft.tfstate"
    access_key = "5lHustFKLMpvjz6X4VFF+TEkyQWm5Y8n+zI7jbBogCT0WzVA0sS/QYO3rYDW1XhPv6NyYfg8pWz4jG8Q/ByB+w=="

      }
    }
}