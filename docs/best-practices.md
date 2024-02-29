# Best practices

This document provides best practices for developing reusable Terraform modules in Equinor.

## Repository

- Use [this template](https://github.com/equinor/terraform-module-template) when creating your repository.

- Use the common naming convention `terraform-azurerm-<name>` when naming your repository.

    For example, if you want to create a module named `storage`, the repository should be named `terraform-azurerm-storage`.

- Configure the following accesses for the repository:

    | Team | Role |
    | --- | --- |
    | @equinor/terraform-baseline | `Write` |
    | @equinor/terraform-baseline-admins | `Admin` |

- Configure the following code owners in a file `.github/CODEOWNERS`:

    ```raw
    * @equinor/terraform-baseline
    ```

- Add topic `terraform-baseline` to the repository.

## Roles and scope

- Use resources that do not require more than `Contributor` role at the resource group scope.
  If you need to use a higher role, create an example instead.

## Hidden resources

- Don't create resources that are automatically created by Azure, e.g. hidden resources such as the `master` database for an Azure SQL server:

  ![hidden resources](img/hidden-resources.png)

## Variables

- All arguments should be made available as variables with sensible default values to make the module as generic as possible. Default values should be the most generic and secure values possible.

   > **Example generic value:** `account_kind` set to `StorageV2` instead of  `BlobStorage` for `storage` module.
   >
   > **Example secure value:** `min_tls_version` set to `1.2` instead of `1.0` for `storage` module.

- Required variables (variables without default values) should be placed first in `variables.tf`.

### Variable naming convention

Variables and outputs should follow a common naming convention `<resource>_<block>_<argument>`, where `<resource>` and/or `<block>` can be omitted if not applicable.

- Use `description` to explain the use case of variables and outputs.

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

  > **Known exceptions to this rule:**
  >
  > - Variable names that contain the module name. For example, in module `storage` the variable `storage_account_name` should be named `account_name` instead.

## Modules

- A single module call should create a single instance of the main resource created by the module. For example, the `web-app` module should create a single web app, and the `sql` module should create a single database. This creates a common expectation for the behavior of our modules.
- A module should not create just a single resource. Exceptions can be made if that resource requires complex configuration or a stringent set of predefined parameters.

### Control plane and data plane

- A module should only perform control plane operations (e.g., managing Storage account or Key vault), not data plane operations (e.g., managing Storage container or Key vault secret). See [control plane and data plane](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/control-plane-and-data-plane) in Microsoft docs.

  Performing data plane operations usually require workarounds for dealing with firewalls when run from an automated pipeline that deviate from the deterministic approach promoted by Terraform (e.g, temporarily disabling firewall or temporarily adding own IP to firewall).
  This may lead to the decision of disabling a resource firewall because it is preventing data plane operations from a pipeline, lowering the security of the resource.

  Data plane operations should be handled outside of Terraform.

  > **Note** Might be irrelevant depending on the implementation of github/roadmap#614.

## Automated tests

- Automated tests should be implemented for all variants of the relevant resource using [Terratest](https://terratest.gruntwork.io/). For example, in the `storage` module, automated tests should be implemented for standard GPv2 storage, premium GPv2 storage, standard blob storage, premium block blob storage and premium file storage.

## Resources

- By default, configure resources based on Microsoft security recommendations, e.g. [Security recommendations for Blob storage](https://learn.microsoft.com/en-us/azure/storage/blobs/security-recommendations).

### Repeatable resources

- For **named** repeatable resources (resources that support argument `name`), use a variable of type `map(object())` to dynamically create the resources, where setting the value to `{}` will not create any resources.

    ```terraform
    variable "firewall_rules" {
      description = "A map of SQL firewall rules to create."

      type = map(object({
        name             = string
        start_ip_address = string
        end_ip_address   = string
      }))

      default = {}
    }

    resource "azurerm_mssql_firewall_rule" "this" {
      for_each = var.firewall_rules

      name             = each.value.name
      start_ip_address = each.value.start_ip_address
      end_ip_address   = each.value.end_ip_address
    }
    ```

- For **unnamed** repeatable resources (usually a resources that link other resources together), use a variable of type `list(object())` to dynamically create the resources, where setting the value to `[]` will not create any resources.

    ```terraform
    variable "job_schedules" {
      description = "A list of Automation job schedules to create."

      type = list(object({
        runbook_name  = string
        schedule_name = string
      }))

      default = []
    }

    resource "azurerm_automation_job_schedule" "this" {
      count = length(var.job_schedules)

      runbook_name            = var.job_schedules[count.index].runbook_name
      schedule_name           = var.job_schedules[count.index].schedule_name
    }
    ```

### Repeatable nested blocks

- For repeatable nested blocks, use a variable of type `list(object())` to dynamically create the nested blocks, where setting the value to `[]` will not create any nested blocks:

    ```terraform
    variable "auth_settings_active_directory" {
      description = "A list of authentication settings using the Active Directory provider to configure for this Linux web app."

      type = list(object({
        client_id                  = string
        client_secret_setting_name = string
      }))

      default = []
    }

    resource "azurerm_linux_web_app" "this" {
      # omitted

      auth_settings {
        enabled = length(var.auth_settings_active_directory) == 0 ? false : true

        dynamic "active_directory" {
          for_each = var.auth_settings_active_directory

          content {
            client_id                  = active_directory.value["client_id"]
            client_secret_setting_name = active_directory.value["client_secret_setting_name"]
          }
        }
      }
    }
    ```

### Non-repeatable nested blocks

- For non-repeatable nested blocks, use a variable of type `object()` to dynamically create the nested block, where setting the value to `null` will not create the nested block.

  **Note:** This is important because the nested block may not be supported in certain scenarios. For example, `blob_properties` for `azurerm_storage_account` is only supported if `account_kind` is set to `StorageV2` or `BlobStorage`.

    ```terraform
    variable "account_kind" {
      description = "The kind of storage account to create."
      type        = string
      default     = "StorageV2"
    }

    variable "blob_properties" {
      description = "The blob properties for this storage account."

      type = object({
        versioning_enabled  = optional(bool, true)
        change_feed_enabled = optional(bool, true)
      })

      default = {}
    }

    resource "azurerm_storage_account" "this" {
      # omitted
      account_kind = var.account_kind

      dynamic "blob_properties" {
        for_each = var.blob_properties != null ? [var.blob_properties] : []

        content {
          versioning_enabled  = blob_properties.value["versioning_enabled"]
          change_feed_enabled = blob_properties.value["change_feed_enabled"]
        }
      }
    }
    ```

    > Known exceptions to this rule would be:
    >
    > - Blocks that are defined as required by the provider (e.g. the `site_config` block for the `azurerm_linux_web_app` resource).
    > - Blocks that are optional but requires an argument to enable/disable its functionality (e.g. the `auth_settings` block for the `azurerm_linux_web_app` resource which requires an argument `enabled`).

## Lifecycle meta-arguments

- The [`prevent_destroy` lifecycle meta-argument](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle#prevent_destroy) should be used sparingly. A [`CanNotDelete` lock](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources) should be used instead.

- The [`ignore_changes` lifecycle meta-argument](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle#ignore_changes) should be used sparingly, as heavy use could lead to configuration drift.
