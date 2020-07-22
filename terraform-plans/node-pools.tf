
data "azurerm_subnet" "aks_subnet"{
}

resource "azurerm_kubernetes_cluster_node_pool" "firstpool" {
  name                  = "internal"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.enterprise.id
  vm_size               = "Standard_DS1_v2"
  enable_auto_scaling  = "true"
  min_count = "2"
  max_count = "5"
  vnet_subnet_id = azurerm_subnet.aks_subnet.id
  availability_zones = ["1", "2"]
  tags = {
    Environment = "dev"
  }
}