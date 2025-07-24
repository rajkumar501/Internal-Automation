

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

resource "azurerm_kubernetes_cluster_node_pool" "userpool" {
  name                  = "user"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.enterprise.id
  vm_size               = var.userpool_vm_size
  auto_scaling_enabled  = true
  min_count             = 1
  max_count             = 10
  node_labels           = { "role" = "user" }
  node_taints           = ["workload=user:NoSchedule"]
  vnet_subnet_id        = var.subnet_id
  zones                 = var.user_pool_zones
  os_disk_type          = "Ephemeral"
  os_disk_size_gb       = 64
  orchestrator_version  = var.kubernetes_version
  max_pods              = 100
  tags                  = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "spotpool" {
  name                  = "spot"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.enterprise.id
  vm_size               = var.spotpool_vm_size
  auto_scaling_enabled  = true
  min_count             = 1
  max_count             = 5
  node_labels           = { "role" = "spot" }
  node_taints           = ["kubernetes.azure.com/scalesetpriority=spot:NoSchedule"]
  vnet_subnet_id        = var.subnet_id
  zones                 = var.spot_pool_zones
  os_disk_type          = "Ephemeral"
  os_disk_size_gb       = 64
  orchestrator_version  = var.kubernetes_version
  max_pods              = 100
  priority              = "Spot"
  eviction_policy       = "Delete"
  tags                  = var.tags
}

variable "userpool_vm_size" {
  description = "VM size for the user node pool"
  type        = string
  default     = "Standard_DS3_v2"
}

variable "spotpool_vm_size" {
  description = "VM size for the spot node pool"
  type        = string
  default     = "Standard_D4as_v5"
}

variable "system_pool_zones" {
  description = "Availability zones for system node pool"
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "user_pool_zones" {
  description = "Availability zones for user node pool"
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "spot_pool_zones" {
  description = "Availability zones for spot node pool"
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "kubernetes_version" {
  description = "Kubernetes version for the cluster and node pools"
  type        = string
  default     = "1.28.3"
}