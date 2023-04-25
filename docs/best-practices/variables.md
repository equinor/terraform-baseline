# Variables

- All arguments should be made available as variables with sensible default values to make the module as generic as possible. Default values should be the most generic and secure values possible.

   Example generic value: `account_kind` set to `StorageV2` instead of  `BlobStorage` for `storage` module.

   Example secure value: `min_tls_version` set to `1.2` instead of `1.0` for `storage` module.

- Required variables (variables without default values) should be placed first in `variables.tf`.

- Variables and outputs should follow a common naming convention `<resource>_<block>_<argument>`, where `<resource>` and/or `<block>` can be omitted if not applicable.

  Use `description` to explain the use case of variables and outputs.

  ```terraform
  variable "vault_name" {
    description = "The name of this key vault."
    type        = string
  }

  variable "diagnostic_setting_name" {
    description = "The name of this diagnostic setting."
    type        = string
  }

  variable "network_acls_virtual_network_subnet_ids" {
    description = "A list of virtual network subnet IDs that should be able to bypass the network ACL and access this key vault."
    type        = list(string)
    default     = []
  }

  resource "azurerm_key_vault" "this" {
    name = var.vault_name
    # omitted

    network_acls {
      # omitted
      virtual_network_subnet_ids = var.network_acls_virtual_network_subnet_ids
    }
  }

  resource "azurerm_monitor_diagnostic_setting" "this" {
    name               = var.diagnostic_setting_name
    target_resource_id = azurerm_key_vault.this.id
    # omitted
  }
  ```

  Known exceptions to this rule:

  1. Variable names that contain the module name. For example, in module `storage` the variable `storage_account_name` should be named `account_name` instead.
