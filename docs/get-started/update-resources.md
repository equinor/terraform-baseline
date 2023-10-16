# Update resources

Next, we'll update the replication type of the Storage account:

1. Check Storage account SKU name:

    ```console
    $ az storage account list --query "[?contains(name, 'examplest')].sku.name" -o tsv
    Standard_LRS
    ```

1. In your Terraform configuration, change the replication type of the Storage account from `LRS` to `GRS`:

    ```terraform
    resource "azurerm_storage_account" "example" {
      # omitted
      account_replication_type = "GRS" # LRS => GRS
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
      ~ update in-place

    Terraform will perform the following actions:

      # azurerm_storage_account.example will be updated in-place
      ~ resource "azurerm_storage_account" "example" {
          ~ account_replication_type          = "LRS" -> "GRS"
            id                                = "/subscriptions/<SUBSCRIPTION_ID>/resourceGroups/example-rg/providers/Microsoft.Storage/storageAccounts/examplestd64f295a"
            name                              = "examplestd64f295a"
            tags                              = {}
            # (36 unchanged attributes hidden)

            # (4 unchanged blocks hidden)
        }

    Plan: 0 to add, 1 to change, 0 to destroy.
    ```

    </details>

1. Run the execution plan to apply the changes:

    ```console
    terraform apply tfplan
    ```

1. Verify that the Storage account SKU name has been changed from `Standard_LRS` to `Standard_GRS`:

    ```console
    $ az storage account list --query "[?contains(name, 'examplest')].sku.name" -o tsv
    Standard_GRS
    ```

You've just made an update to the Storage account through Terraform!

Since we're nearing the end of this tutorial, it's time to tear down the Storage account that we've created.
