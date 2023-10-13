# Equinor Terraform Baseline

Equinor Terraform Baseline (ETB) is...

## Prerequisites

- Install [Terraform](https://developer.hashicorp.com/terraform/downloads)
- Install [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) - for authenticating to Azure

## Intro

- Write very short about Terraform, pros cons etc.

- Resources, data sources, modules

  - Resource and data sources defined by the providers.

  - Modules defined by you (and the community)!

- Resource and data source definition syntax

- Where is documentation?

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

1. Get the resource group using a data source:

    ```terraform
    data "azurerm_resource_group" "example" {
      name = "example-rg"
    }
    ```

1. Create a storage account:

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
