

resource "azurerm_kubernetes_cluster_node_pool" "apppool" {
  name                  = "app"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.enterprise.id
  vm_size               = "Standard_DS2_v2"
  //enable_auto_scaling  = "true"
 // min_count = "2"
  // max_count = "5"
  node_count= "3"
  tags = {
    Environment = "dev"
  }
}