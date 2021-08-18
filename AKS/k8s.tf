resource "azurerm_kubernetes_cluster" "kc" {
  for_each = var.cluster
  name = each.value.name
  location = each.value.location
  resource_group_name = each.value.resourcegroup
  dns_prefix = each.value.dns_prefix

  linux_profile {
    admin_username = try(each.value.admin_username, "dyerram")
    ssh_key {
      key_data = file(var.ssh_pubkey) #spin up keyvault 
    }
  }

  dynamic "service_principal" {
    for_each = each.value.service_principal
    content {
    client_id = service_principal.value.client_id
    client_secret = service_principal.value.client_secret
    }
  }

 addon_profile {
    http_application_routing {
      enabled = try(each.value.addon_profile.http_routing_enabled, false)
    }
  }

  dynamic "default_node_pool" { 
    for_each = each.value.default_node_pool
    content {
    name            = default_node_pool.value.name
    node_count      = default_node_pool.value.node_count
    vm_size         = default_node_pool.value.vm_size
    os_disk_size_gb = default_node_pool.value.os_disk_size_gb
    vnet_subnet_id  = default_node_pool.value.vnet_subnet_id == " " ?  data.azurerm_subnet.kubesubnet.id : default_node_pool.value.vnet_subnet_id
    }
  }

  network_profile {
    network_plugin     = try(each.value.network_profile.network_plugin,"azure")
    dns_service_ip     = each.value.network_profile.dns_service_ip
    docker_bridge_cidr = each.value.network_profile.docker_bridge_cidr
    service_cidr       =each.value.network_profile.service_cidr
  }

  role_based_access_control {
    enabled = each.value.rbac_enabled
  }

  tags       = var.tags
}
