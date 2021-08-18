variable "location"{
    default = "Central US"
}

variable "dns_prefix" {
    default = "k8test"
}

variable "agent_count" {
    default = 3
}
variable "ssh_pubkey"{
    default = "~/.ssh/id_rsa.pub"
}

variable "client_id"{
    default = ""
}

variable "client_secret"{
    default = ""
}

variable log_analytics_workspace_name {
    default = "testLogAnalyticsWorkspaceName"
}

# refer https://azure.microsoft.com/global-infrastructure/services/?products=monitor for log analytics available regions
variable log_analytics_workspace_location {
    default = "eastus"
}

# refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing 
variable log_analytics_workspace_sku {
    default = "PerGB2018"
}


##################

variable "cluster" {
  type = map(object({
    name = string
    location = string
    resourcegroup = string
    dns_prefix = string
    rbac_enabled = bool
    network_profile = object({
      network_plugin = string
      dns_service_ip = string
      docker_bridge_cidr = string
      service_cidr = string
    })
    addon_profile=object({
        http_routing_enabled = bool
    })
    service_principal = map(object({
      client_id = string
      client_secret = string
    }))
    default_node_pool = map(object({
      name = string
      node_count = number
      vm_size = string
      os_disk_size_gb = string
      vnet_subnet_id = string 
    }))
  }))
 default = {
   "aks1" = {
     addon_profile = {
       http_routing_enabled = false
     }
     dns_prefix = "value"
     default_node_pool = {
       "cluster1" = {
         name = "test"
         node_count = 1
         os_disk_size_gb = "30"
         vm_size = "Standard_D2s_v3"
         vnet_subnet_id = " "
       }
     }
     location = "Central US"
     name = "aks1"
     network_profile = {
       dns_service_ip = "10.0.0.10"
       docker_bridge_cidr = "172.17.0.1/16"
       network_plugin = "azure"
       service_cidr = "10.0.0.0/16"
     }
     resourcegroup = "rg-dyerram-sandbox-cus-001"
     rbac_enabled = false
     service_principal = {
       "sp1" = {
         client_id = ""
         client_secret = ""
       }
     }
   }
 }
  
}



variable "virtual_network_name" {
  description = "Virtual network name"
  default     = "aksVirtualNetwork"
}

variable "virtual_network_address_prefix" {
  description = "VNET address prefix"
  default     = "15.0.0.0/8"
}

variable "aks_subnet_name" {
  description = "Subnet Name."
  default     = "kubesubnet"
}

variable "aks_subnet_address_prefix" {
  description = "Subnet address prefix."
  default     = "15.0.0.0/16"
}

variable "app_gateway_subnet_address_prefix" {
  description = "Subnet server IP address."
  default     = "15.1.0.0/16"
}

variable "app_gateway_name" {
  description = "Name of the Application Gateway"
  default = "ApplicationGateway1"
}

variable "app_gateway_sku" {
  description = "Name of the Application Gateway SKU"
  default = "Standard_v2"
}

variable "app_gateway_tier" {
  description = "Tier of the Application Gateway tier"
  default = "Standard_v2"
}

variable "aks_name" {
  description = "AKS cluster name"
  default     = "aks-cluster1"
}
variable "aks_dns_prefix" {
  description = "Optional DNS prefix to use with hosted Kubernetes API server FQDN."
  default     = "aks"
}

variable "aks_agent_os_disk_size" {
  description = "Disk size (in GB) to provision for each of the agent pool nodes. This value ranges from 0 to 1023. Specifying 0 applies the default disk size for that agentVMSize."
  default     = 40
}

variable "aks_agent_count" {
  description = "The number of agent nodes for the cluster."
  default     = 3
}

variable "aks_agent_vm_size" {
  description = "VM size"
  default     = "Standard_D2_v2"
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  default     = "1.21.0"
}

variable "aks_service_cidr" {
  description = "CIDR notation IP range from which to assign service cluster IPs"
  default     = "10.0.0.0/16"
}

variable "aks_dns_service_ip" {
  description = "DNS server IP address"
  default     = "10.0.0.10"
}

variable "aks_docker_bridge_cidr" {
  description = "CIDR notation IP for Docker bridge."
  default     = "172.17.0.1/16"
}

variable "aks_enable_rbac" {
  description = "Enable RBAC on the AKS cluster. Defaults to false."
  default     = "false"
}

variable "vm_user_name" {
  description = "User name for the VM"
  default     = ""
}

variable "public_ssh_key_path" {
  description = "Public key path for SSH."
  default     = "~/.ssh/id_rsa.pub"
}

variable "tags" {
  type = map(string)

  default = {
    source = "terraform"
  }
}