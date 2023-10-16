# Prerequisites

## Install tools

- Install [Terraform](https://developer.hashicorp.com/terraform/downloads){target=_blank}
- Install [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli){target=_blank}
- If you're using VS Code, install the [Terraform Extension for VS Code](https://marketplace.visualstudio.com/items?itemName=hashicorp.terraform){target=_blank}

## Create resource group in Azure

Using the Azure CLI, create a resource group in Azure to contain the resources created during this tutorial:

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
    $ az group create -n example-rg -l northeurope -o table
    Location     Name
    -----------  ----------
    northeurope  example-rg
    ```

Now we're ready to start learning about Terraform, starting with the basic syntax.
