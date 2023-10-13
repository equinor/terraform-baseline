# Prerequisites

## Install tools

- Install [Terraform](https://developer.hashicorp.com/terraform/downloads)
- Install [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) - for authenticating to Azure
- If you're using VS Code, install the [Terraform Extension for VS Code](https://marketplace.visualstudio.com/items?itemName=hashicorp.terraform)

## Create resource group in Azure

Before we can start creating Azure resources using Terraform, we'll create a resource group to contain the resources using the Azure CLI:

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

Note that we **could** have created the resource group using Terraform, however resource groups are often provisioned by Subscription Owners.

If someone else has to create this resource group for you, ensure that you are assigned role `Contributor` at the resource group scope.
