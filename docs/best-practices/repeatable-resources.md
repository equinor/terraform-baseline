# Repeatable resources

- For repeatable resources that extend the main resource, use a variable of type `map(object())` to dynamically create the resources, where setting the value to `{}` will not create any resources.

    ```terraform
    variable "server_name" {
      description = "The name of this SQL server."
      type        = string
    }

    variable "firewall_rules" {
      description = "A map of firewall rules to create for this SQL server."

      type = map(object({
        name             = string
        start_ip_address = string
        end_ip_address   = string
      }))

      default = {
        this = {
          name             = "AllowAllWindowsAzureIps"
          start_ip_address = "0.0.0.0"
          end_ip_address   = "0.0.0.0"
        }
      }
    }

    resource "azurerm_mssql_server" "this" {
      name = var.server_name
      # omitted
    }

    resource "azurerm_mssql_firewall_rule" "this" {
      for_each = var.firewall_rules

      name             = each.value.name
      server_id        = azurerm_mssql_server.this.id
      start_ip_address = each.value.start_ip_address
      end_ip_address   = each.value.end_ip_address
    }
    ```

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

- For non-repeatable nested blocks, use a variable of type `object()` to dynamically create the nested block, where setting the value to `null` will not create the nested block.

    This is important because the nested block may not be supported in certain scenarios. For example, `blob_properties` for `azurerm_storage_account` is only supported if `account_kind` is set to `StorageV2` or `BlobStorage`.

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

    Known exceptions to this rule would be:

    1. Blocks that are defined as required by the provider (e.g. the `site_config` block for the `azurerm_linux_web_app` resource).
    1. Blocks that are optional but requires an argument to enable/disable its functionality (e.g. the `auth_settings` block for the `azurerm_linux_web_app` resource which requires an argument `enabled`).
