resource "azurerm_resource_group" "k8s" {
  name     = var.resource_group_name
  location = var.location
}

resource "random_id" "log_analytics_workspace_name_suffix" {
  byte_length = 8
}

resource "azurerm_log_analytics_workspace" "test" {
  name                = "${var.log_analytics_workspace_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
  location            = var.log_analytics_workspace_location
  resource_group_name = azurerm_resource_group.k8s.name
  sku                 = var.log_analytics_workspace_sku
}

resource "azurerm_log_analytics_solution" "test" {
  solution_name         = "ContainerInsights"
  location              = var.log_analytics_workspace_location
  resource_group_name   = azurerm_resource_group.k8s.name
  workspace_resource_id = azurerm_log_analytics_workspace.test.id
  workspace_name        = azurerm_log_analytics_workspace.test.name
  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

resource "azurerm_kubernetes_cluster" "enterprise" {
  name                = var.cluster_name
  location            = azurerm_resource_group.k8s.location
  resource_group_name = azurerm_resource_group.k8s.name
  dns_prefix          = var.dns_prefix

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control_enabled = true
  azure_active_directory_role_based_access_control {
    managed                = true
    admin_group_object_ids = var.admin_group_object_ids
    azure_rbac_enabled     = true
  }

  network_profile {
    network_plugin    = var.network_plugin
    network_policy    = var.network_policy
    load_balancer_sku = var.load_balancer_sku
    outbound_type     = var.outbound_type
  }

  api_server_authorized_ip_ranges = var.api_server_authorized_ip_ranges

  default_node_pool {
    name                         = "systempool"
    vm_size                      = var.default_vm_size
    only_critical_addons_enabled = var.only_critical_addons_enabled
    enable_auto_scaling          = false
    node_count                   = var.default_node_count
    os_disk_type                 = var.default_os_disk_type
    os_disk_size_gb              = var.default_os_disk_size_gb
    vnet_subnet_id               = var.subnet_id
    zones                        = var.system_pool_zones
    max_pods                     = var.default_max_pods
    orchestrator_version         = var.default_orchestrator_version
    temporary_name_for_rotation  = var.default_temporary_name_for_rotation
  }

  azure_policy_enabled = var.azure_policy_enabled
  oidc_issuer_enabled = var.oidc_issuer_enabled
  workload_identity_enabled = var.workload_identity_enabled
  private_cluster_enabled = var.private_cluster_enabled
  local_account_disabled = var.local_account_disabled

  addon_profile {
    oms_agent {
      enabled                    = var.oms_agent_enabled
      log_analytics_workspace_id = azurerm_log_analytics_workspace.test.id
    }
    azure_policy {
      enabled = var.azure_policy_addon_enabled
    }
  }

  maintenance_window {
    allowed = [{
      day   = var.maintenance_window_day
      hours = var.maintenance_window_hours
    }]
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = var.tags
}
