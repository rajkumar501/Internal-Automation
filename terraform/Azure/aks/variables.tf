variable "client_id" {}
variable "client_secret" {}

variable "agent_count" {
    default = 2
}

variable "ssh_public_key" {
    default = "/home/jenkins/agent/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
    default = "enterprise"
}

variable cluster_name {
    default = "enterprise"
}

variable resource_group_name {
    default = "rg-aks-test"
}

variable location {
    default = "East US"
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

variable "admin_group_object_ids" {
  description = "List of Azure AD group object IDs for AKS admin access"
  type        = list(string)
}

variable "api_server_authorized_ip_ranges" {
  description = "List of authorized IP ranges for the AKS API server"
  type        = list(string)
  default     = []
}

variable "default_vm_size" {
  description = "VM size for the default node pool"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "subnet_id" {
  description = "Subnet ID for AKS nodes"
  type        = string
}

variable "tags" {
  description = "Tags for AKS resources"
  type        = map(string)
  default     = {}
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

variable "network_plugin" {
  description = "Network plugin for AKS (azure or kubenet)"
  type        = string
  default     = "azure"
}

variable "network_policy" {
  description = "Network policy for AKS (azure, calico, cilium)"
  type        = string
  default     = "azure"
}

variable "load_balancer_sku" {
  description = "Load balancer SKU (basic or standard)"
  type        = string
  default     = "standard"
}

variable "outbound_type" {
  description = "Outbound type for AKS (loadBalancer, userDefinedRouting)"
  type        = string
  default     = "userDefinedRouting"
}

variable "default_node_count" {
  description = "Node count for the default (system) node pool"
  type        = number
  default     = 2
}

variable "default_os_disk_type" {
  description = "OS disk type for the default node pool (Ephemeral or Managed)"
  type        = string
  default     = "Ephemeral"
}

variable "default_os_disk_size_gb" {
  description = "OS disk size in GB for the default node pool"
  type        = number
  default     = 64
}

variable "default_max_pods" {
  description = "Maximum pods per node in the default node pool"
  type        = number
  default     = 100
}

variable "default_orchestrator_version" {
  description = "Kubernetes version for the default node pool"
  type        = string
  default     = "1.28.3"
}

variable "default_temporary_name_for_rotation" {
  description = "Temporary name for system node pool rotation"
  type        = string
  default     = "poolrot"
}

variable "only_critical_addons_enabled" {
  description = "Only allow critical addons on system node pool"
  type        = bool
  default     = true
}

variable "private_cluster_enabled" {
  description = "Enable private cluster mode"
  type        = bool
  default     = true
}

variable "local_account_disabled" {
  description = "Disable local account for AKS"
  type        = bool
  default     = true
}

variable "azure_policy_enabled" {
  description = "Enable Azure Policy on AKS cluster"
  type        = bool
  default     = true
}

variable "oidc_issuer_enabled" {
  description = "Enable OIDC issuer for AKS cluster"
  type        = bool
  default     = true
}

variable "workload_identity_enabled" {
  description = "Enable workload identity for AKS cluster"
  type        = bool
  default     = true
}

variable "maintenance_window_day" {
  description = "Day for maintenance window"
  type        = string
  default     = "Sunday"
}

variable "maintenance_window_hours" {
  description = "Hours for maintenance window (list of numbers)"
  type        = list(number)
  default     = [22, 23]
}

variable "oms_agent_enabled" {
  description = "Enable OMS agent (Container Insights)"
  type        = bool
  default     = true
}

variable "azure_policy_addon_enabled" {
  description = "Enable Azure Policy addon in AKS"
  type        = bool
  default     = true
}