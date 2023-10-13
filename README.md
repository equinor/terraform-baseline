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
    # Create a random ID suffix for resource names using the built-in random provider
    resource "random_id" "suffix" {
      byte_length = 8
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

1. Validate your Terraform configuration to check for errors such as non-existent references:

    ```console
    terraform validate
    ```

1. create a Terraform plan and store it in a file `tfplan`:

    ```console
    terraform plan -out=tfplan
    ```

1. Apply the changes presented by the Terraform plan.

    ```console
    terraform apply tfplan
    ```
