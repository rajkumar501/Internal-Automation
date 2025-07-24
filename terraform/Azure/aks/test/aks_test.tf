variable "client_id" {}
variable "client_secret" {}
variable "resource_group_name" {}
variable "location" {}
variable "cluster_name" {}
variable "dns_prefix" {}
variable "ssh_public_key" {}
variable "log_analytics_workspace_name" {}
variable "log_analytics_workspace_location" {}
variable "log_analytics_workspace_sku" {}

// Basic test cases for AKS module

module "aks" {
  source                        = "../"
  client_id                     = var.client_id
  client_secret                 = var.client_secret
  resource_group_name           = var.resource_group_name
  location                      = var.location
  cluster_name                  = var.cluster_name
  dns_prefix                    = var.dns_prefix
  ssh_public_key                = var.ssh_public_key
  log_analytics_workspace_name  = var.log_analytics_workspace_name
  log_analytics_workspace_location = var.log_analytics_workspace_location
  log_analytics_workspace_sku   = var.log_analytics_workspace_sku
}

output "test_kube_config" {
  value = module.aks.kube_config
}

output "test_node_pool_count" {
  value = module.aks.default_node_pool_count
} 