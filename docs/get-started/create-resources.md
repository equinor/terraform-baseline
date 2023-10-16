# Create resources

Let's create an Azure Storage account using Terraform:

1. Create a file `main.tf`.

1. Configure the Azure provider:

    ```terraform
    provider "azurerm" {
      features {}
    }
    ```

1. Read the Azure resource group you created into Terraform by using a data source:

    ```terraform
    data "azurerm_resource_group" "example" {
      name = "example-rg"
    }
    ```

1. Create a random suffix for resource names using the built-in random provider, and an Azure Storage account in the resource group:

    ```terraform
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

    <details><summary>Show `main.tf` contents</summary>

    ```console
    $ cat main.tf
    provider "azurerm" {
      features {}
    }

    data "azurerm_resource_group" "example" {
      name = "example-rg"
    }

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

    </details>

1. Initialize your Terraform configuration to install all required provider plugins:

    ```console
    terraform init
    ```

    Two files will be automatically created:

    | Name | Description |
    | --- | --- |
    | `.terraform` | A directory containing installed provider plugins |
    | `.terraform.lock.hcl` | A file containing a record of installed provider plugins |

1. Validate your Terraform configuration to check for errors such as non-existent references:

    ```console
    terraform validate
    ```

1. Generate an execution plan and store it in a file `tfplan`:

    ```console
    terraform plan -out=tfplan
    ```

    A single file will be automatically created:

    | Name | Description |
    | --- | --- |
    | `tfplan` | A file containing the generated execution plan |

    <details><summary>Show execution plan</summary>

    ```console
    $ terraform show tfplan

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
    ```

    </details>

1. Run the execution plan:

    ```console
    terraform apply tfplan
    ```

    This will create the resources shown in the execution plan.

    A single file will be automatically created:

    | Name | Description |
    | --- | --- |
    | `terraform.tfstate` | A file containing the last known configuration (state) of your infrastructure |

    Feel free to have a quick look at the state file.
    Notice how the state file keeps track of the configuration of all read data sources and created resources.
    You must never modify the state file manually; all changes should go through Terraform.

1. Verify that the Storage account has been created in the resource group:

    ```console
    $ az resource list -g example-rg -o table
    Name               ResourceGroup    Location     Type                               Status
    -----------------  ---------------  -----------  ---------------------------------  --------
    examplestd64f295a  example-rg       northeurope  Microsoft.Storage/storageAccounts
    ```

    > It might take a few minutes before the Storage account appears in the output.

Congrats, you've created your first resource using Terraform!

As mentioned earlier, Terraform not only allows you to create new resources, but to effectively manage its entire lifecycle.

Next, we'll make an update to the Storage account configuration, before we tear it all down again!
