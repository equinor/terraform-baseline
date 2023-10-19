# Usage examples

## Prerequisites

- Must be assigned role `Contributor` at the subscription scope.

- Create a file `main.tf` with the following contents:

    ```terraform
    provider "azurerm" {
      features {}
    }

    resource "random_id" "example" {
      byte_length = 8
    }

    resource "azurerm_resource_group" "example" {
      name     = "rg-${random_id.example.hex}"
      location = "northeurope"
    }
    ```

    It will:

    - Configure the Azure provider.
    - Create a random identifier to generate random resource names.
    - Create an Azure resource group to contain resources.

## Setup Azure Log Analytics

```terraform
module "log_analytics" {
  source = "github.com/equinor/terraform-azurerm-log-analytics?ref=v2.1.1"

  workspace_name      = "log-${random_id.example.hex}"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}
```

## Setup Azure Key Vault

```terraform
module "key_vault" {
  source = "github.com/equinor/terraform-azurerm-key-vault?ref=v11.2.0"

  vault_name                 = "kv-${random_id.example.hex}"
  resource_group_name        = azurerm_resource_group.example.name
  location                   = azurerm_resource_group.example.location
  log_analytics_workspace_id = module.log_analytics.workspace_id

  # List of IP addresses or IP ranges in CIDR format
  network_acls_ip_rules = []
}
```

## Setup Azure Storage

```terraform
module "storage" {
  source = "github.com/equinor/terraform-azurerm-storage?ref=v12.1.1"

  account_name               = "st${random_id.example.hex}"
  resource_group_name        = azurerm_resource_group.example.name
  location                   = azurerm_resource_group.example.location
  log_analytics_workspace_id = module.log_analytics.workspace_id

  # List of IP addresses or IP ranges in CIDR format
  network_rules_ip_rules = []
}
```
