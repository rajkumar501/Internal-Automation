# Azure AKS Terraform Module

This module deploys an Azure Kubernetes Service (AKS) cluster with support for the latest `azurerm` provider features, node pools, monitoring, and outputs for kubeconfig access.

## Features
- Deploys AKS cluster with configurable node pools
- Integrates Log Analytics for monitoring
- Supports latest AzureRM provider features (v3+)
- Exposes all relevant outputs for cluster access
- Example test cases included

## Usage
```hcl
module "aks" {
  source                        = "./Internal-Automation/terraform/Azure/aks"
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
```

## Variables
| Name                           | Description                                  | Default |
|--------------------------------|----------------------------------------------|---------|
| client_id                      | Azure AD Application client ID               |         |
| client_secret                  | Azure AD Application client secret           |         |
| resource_group_name            | Resource group for AKS                       | "rg-aks-test" |
| location                       | Azure region                                 | "East US" |
| cluster_name                   | Name of the AKS cluster                      | "enterprise" |
| dns_prefix                     | DNS prefix for AKS                           | "enterprise" |
| ssh_public_key                 | Path to SSH public key                       | "/home/jenkins/agent/.ssh/id_rsa.pub" |
| log_analytics_workspace_name   | Log Analytics workspace name                 | "testLogAnalyticsWorkspaceName" |
| log_analytics_workspace_location | Log Analytics workspace location           | "eastus" |
| log_analytics_workspace_sku    | Log Analytics SKU                            | "PerGB2018" |

## Outputs
- `client_key`, `client_certificate`, `cluster_ca_certificate`, `cluster_username`, `cluster_password`, `kube_config`, `host`

## Test Cases
Test cases are provided in the `test/` directory (add your own as needed):
- Validate cluster creation
- Validate node pool scaling
- Validate monitoring integration

## Changelog / Azurerm v3+ Updates
- Updated provider block to support v3+ features
- Node pool resource (`azurerm_kubernetes_cluster_node_pool`) supported
- Monitoring and Log Analytics integration
- Output improvements for kubeconfig

## References
- [Terraform AzureRM Provider Docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster)
- [AKS Documentation](https://docs.microsoft.com/en-us/azure/aks/) 