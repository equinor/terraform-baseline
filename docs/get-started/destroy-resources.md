# Destroy resources

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

    <details><summary>Show execution plan</summary>

    ```console
    $ terraform show tfplan

    Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
      - destroy

    Terraform will perform the following actions:

      # azurerm_storage_account.example will be destroyed
      # (because azurerm_storage_account.example is not in configuration)
      - resource "azurerm_storage_account" "example" {
          - access_tier                       = "Hot" -> null
          - account_kind                      = "StorageV2" -> null
          - account_replication_type          = "GRS" -> null
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
    ```

    </details>

    Note how the plan wants to destroy the previously created resources.
    This is because those resources no longer exist in your code.
    If resources have been removed from your code, they should also be removed from Azure.

1. Run the execution plan:

    ```console
    terraform apply tfplan
    ```

1. Verify that the resource group is empty again:

    ```console
    az resource list -g example-rg -o table
    ```

    If nothing is returned, then the resource group is empty, meaning that the Storage account has been destroyed.

Congrats, you've managed the full lifecycle of an Azure Storage account using Terraform!
