# Equinor Terraform Baseline

Equinor Terraform Baseline (ETB) is...

## Prerequisites

- Install [Terraform](https://developer.hashicorp.com/terraform/downloads)
- Install [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) - for authenticating to Azure
- If you're using VS Code, install the [Terraform Extension for VS Code](https://marketplace.visualstudio.com/items?itemName=hashicorp.terraform)
- Basic Azure knowledge (familiar with subscriptions, resource groups and resources)

## Why Terraform?

Write very short about Terraform, pros cons etc.

### Providers

### Resources and data sources

- Resources, data sources, modules

- Resource and data sources defined by the providers.

- Resource and data source definition syntax

    ```terraform
    resource "<provider>_<resource>" "<label>" {
      # arguments
    }
    ```

- Where is documentation?

### Modules

- Modules defined by you (and the community)!

- Baseline modules example usage?

## Get started with Terraform

1. Login to Azure:

    ```console
    az login
    ```

1. Set active subscription:

    ```console
    az account set -s <SUBSCRIPTION_NAME_OR_ID>
    ```

1. Create a resource group:

    ```console
    az group create -n example-rg -l northeurope
    ```

1. Create a file `main.tf`.

1. Configure the Azure provider:

    ```terraform
    provider "azurerm" {
      features {}
    }
    ```

1. Read the resource group you created into Terraform by using a data source:

    ```terraform
    data "azurerm_resource_group" "example" {
      name = "example-rg"
    }
    ```

1. Create a storage account in the resource group:

    ```terraform
    # Create a unique suffix for resource names using the built-in random provider
    resource "random_id" "suffix" {
      byte_length = 4
    }

    resource "azurerm_storage_account" "example" {
      name                     = "examplest${random_id.suffix.hex}"
      resource_group_name      = data.azurerm_resource_group.example.name
      location                 = data.azurerm_resource_group.example.location
      account_tier             = "Standard"
      account_replication_type = "LRS"
    }
    ```

1. Your `main.tf` file should now look like [this](terraform/main.tf).

1. Initialize your Terraform configuration.

    ```console
    terraform init
    ```

    This will install all required provider plugins.

    Two files will be automatically created:

    1. `.terraform`: a directory containing installed provider plugins.
    1. `.terraform.lock.hcl`: a file that contains a record of installed provider plugins.

    Feel free to have a quick look at these files, though this is completely optional.

1. Validate your Terraform configuration to check for errors such as non-existent references:

    ```console
    terraform validate
    ```

1. create a Terraform plan and store it in a file `tfplan`:

    ```console
    terraform plan -out=tfplan
    ```

    Something...

    <details><summary>Show execution plan</summary>

    ```terraform
    data.azurerm_resource_group.example: Reading...
    data.azurerm_resource_group.example: Read complete after 0s [id=/subscriptions/<SUBSCRIPTION_ID>/resourceGroups/example-rg]

    Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
      + create

    Terraform will perform the following actions:

      # azurerm_storage_account.example will be created
      + resource "azurerm_storage_account" "example" {
          + access_tier                       = (known after apply)
          + account_kind                      = "StorageV2"
          + account_replication_type          = "LRS"
          + account_tier                      = "Standard"
          + allow_nested_items_to_be_public   = true
          + cross_tenant_replication_enabled  = true
          + default_to_oauth_authentication   = false
          + enable_https_traffic_only         = true
          + id                                = (known after apply)
          + infrastructure_encryption_enabled = false
          + is_hns_enabled                    = false
          + large_file_share_enabled          = (known after apply)
          + location                          = "northeurope"
          + min_tls_version                   = "TLS1_2"
          + name                              = (known after apply)
          + nfsv3_enabled                     = false
          + primary_access_key                = (sensitive value)
          + primary_blob_connection_string    = (sensitive value)
          + primary_blob_endpoint             = (known after apply)
          + primary_blob_host                 = (known after apply)
          + primary_connection_string         = (sensitive value)
          + primary_dfs_endpoint              = (known after apply)
          + primary_dfs_host                  = (known after apply)
          + primary_file_endpoint             = (known after apply)
          + primary_file_host                 = (known after apply)
          + primary_location                  = (known after apply)
          + primary_queue_endpoint            = (known after apply)
          + primary_queue_host                = (known after apply)
          + primary_table_endpoint            = (known after apply)
          + primary_table_host                = (known after apply)
          + primary_web_endpoint              = (known after apply)
          + primary_web_host                  = (known after apply)
          + public_network_access_enabled     = true
          + queue_encryption_key_type         = "Service"
          + resource_group_name               = "example-rg"
          + secondary_access_key              = (sensitive value)
          + secondary_blob_connection_string  = (sensitive value)
          + secondary_blob_endpoint           = (known after apply)
          + secondary_blob_host               = (known after apply)
          + secondary_connection_string       = (sensitive value)
          + secondary_dfs_endpoint            = (known after apply)
          + secondary_dfs_host                = (known after apply)
          + secondary_file_endpoint           = (known after apply)
          + secondary_file_host               = (known after apply)
          + secondary_location                = (known after apply)
          + secondary_queue_endpoint          = (known after apply)
          + secondary_queue_host              = (known after apply)
          + secondary_table_endpoint          = (known after apply)
          + secondary_table_host              = (known after apply)
          + secondary_web_endpoint            = (known after apply)
          + secondary_web_host                = (known after apply)
          + sftp_enabled                      = false
          + shared_access_key_enabled         = true
          + table_encryption_key_type         = "Service"
        }

      # random_id.suffix will be created
      + resource "random_id" "suffix" {
          + b64_std     = (known after apply)
          + b64_url     = (known after apply)
          + byte_length = 8
          + dec         = (known after apply)
          + hex         = (known after apply)
          + id          = (known after apply)
        }

    Plan: 2 to add, 0 to change, 0 to destroy.

    ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

    Saved the plan to: tfplan

    To perform exactly these actions, run the following command to apply:
        terraform apply "tfplan"
    ```

    </details>

    A single file will be automatically created:

    1. `tfplan`: contains the created execution plan.

    If you ever need to review the execution plan again:

    ```console
    terraform show tfplan
    ```

1. Apply the changes presented by the Terraform plan.

    ```console
    terraform apply tfplan
    ```

    A single file will be automatically created:

    - `terraform.tfstate`: ???

    Feel free to have a quick look at the state file.
    Notice how the state file keeps track of the configuration of all read data sources and created resources.
    You should never modify the state file manually; all changes should go through Terraform.

1. Remove all data sources and resources from your code, so that only the provider configuration remains:

    ```terraform
    provider "azurerm" {
      features {}
    }
    ```

1. Generate a new execution plan:

    ```console
    terraform plan -out=tfplan
    ```

1. Run the execution plan:

    ```console
    terraform apply tfplan
    ```

    <details><summary>Show execution plan</summary>

    ```terraform
    random_id.suffix: Refreshing state... [id=1k8pWg]
    azurerm_storage_account.example: Refreshing state... [id=/subscriptions/<SUBSCRIPTION_ID>/resourceGroups/example-rg/providers/Microsoft.Storage/storageAccounts/examplestd64f295a]

    Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
      - destroy

    Terraform will perform the following actions:

      # azurerm_storage_account.example will be destroyed
      # (because azurerm_storage_account.example is not in configuration)
      - resource "azurerm_storage_account" "example" {
          - access_tier                       = "Hot" -> null
          - account_kind                      = "StorageV2" -> null
          - account_replication_type          = "LRS" -> null
          - account_tier                      = "Standard" -> null
          - allow_nested_items_to_be_public   = true -> null
          - cross_tenant_replication_enabled  = true -> null
          - default_to_oauth_authentication   = false -> null
          - enable_https_traffic_only         = true -> null
          - id                                = "/subscriptions/<SUBSCRIPTION_ID>/resourceGroups/example-rg/providers/Microsoft.Storage/storageAccounts/examplestd64f295a" -> null
          - infrastructure_encryption_enabled = false -> null
          - is_hns_enabled                    = false -> null
          - location                          = "northeurope" -> null
          - min_tls_version                   = "TLS1_2" -> null
          - name                              = "examplestd64f295a" -> null
          - nfsv3_enabled                     = false -> null
          - primary_access_key                = (sensitive value) -> null
          - primary_blob_connection_string    = (sensitive value) -> null
          - primary_blob_endpoint             = "https://examplestd64f295a.blob.core.windows.net/" -> null
          - primary_blob_host                 = "examplestd64f295a.blob.core.windows.net" -> null
          - primary_connection_string         = (sensitive value) -> null
          - primary_dfs_endpoint              = "https://examplestd64f295a.dfs.core.windows.net/" -> null
          - primary_dfs_host                  = "examplestd64f295a.dfs.core.windows.net" -> null
          - primary_file_endpoint             = "https://examplestd64f295a.file.core.windows.net/" -> null
          - primary_file_host                 = "examplestd64f295a.file.core.windows.net" -> null
          - primary_location                  = "northeurope" -> null
          - primary_queue_endpoint            = "https://examplestd64f295a.queue.core.windows.net/" -> null
          - primary_queue_host                = "examplestd64f295a.queue.core.windows.net" -> null
          - primary_table_endpoint            = "https://examplestd64f295a.table.core.windows.net/" -> null
          - primary_table_host                = "examplestd64f295a.table.core.windows.net" -> null
          - primary_web_endpoint              = "https://examplestd64f295a.z16.web.core.windows.net/" -> null
          - primary_web_host                  = "examplestd64f295a.z16.web.core.windows.net" -> null
          - public_network_access_enabled     = true -> null
          - queue_encryption_key_type         = "Service" -> null
          - resource_group_name               = "example-rg" -> null
          - secondary_access_key              = (sensitive value) -> null
          - secondary_connection_string       = (sensitive value) -> null
          - sftp_enabled                      = false -> null
          - shared_access_key_enabled         = true -> null
          - table_encryption_key_type         = "Service" -> null
          - tags                              = {} -> null

          - blob_properties {
              - change_feed_enabled           = false -> null
              - change_feed_retention_in_days = 0 -> null
              - last_access_time_enabled      = false -> null
              - versioning_enabled            = false -> null
            }

          - network_rules {
              - bypass                     = [
                  - "AzureServices",
                ] -> null
              - default_action             = "Allow" -> null
              - ip_rules                   = [] -> null
              - virtual_network_subnet_ids = [] -> null
            }

          - queue_properties {
              - hour_metrics {
                  - enabled               = true -> null
                  - include_apis          = true -> null
                  - retention_policy_days = 7 -> null
                  - version               = "1.0" -> null
                }
              - logging {
                  - delete                = false -> null
                  - read                  = false -> null
                  - retention_policy_days = 0 -> null
                  - version               = "1.0" -> null
                  - write                 = false -> null
                }
              - minute_metrics {
                  - enabled               = false -> null
                  - include_apis          = false -> null
                  - retention_policy_days = 0 -> null
                  - version               = "1.0" -> null
                }
            }

          - share_properties {
              - retention_policy {
                  - days = 7 -> null
                }
            }
        }

      # random_id.suffix will be destroyed
      # (because random_id.suffix is not in configuration)
      - resource "random_id" "suffix" {
          - b64_std     = "1k8pWg==" -> null
          - b64_url     = "1k8pWg" -> null
          - byte_length = 4 -> null
          - dec         = "3595512154" -> null
          - hex         = "d64f295a" -> null
          - id          = "1k8pWg" -> null
        }

    Plan: 0 to add, 0 to change, 2 to destroy.

    ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

    Saved the plan to: tfplan

    To perform exactly these actions, run the following command to apply:
        terraform apply "tfplan"
    ```

    </details>

## Summary

What did we learn from the "Get started" section?

## What next?

- [Create reusable modules](docs/reusable-modules.md)
