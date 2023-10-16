# Syntax

A Terraform configuration consists of one or more `.tf` files, which are built around blocks, labels and arguments:

```terraform
<block> "<label>" {
  <argument> = <value>
}
```

In this tutorial, you'll get familiar with the three most common block types in Terraform:

1. Provider blocks
1. Resource blocks
1. Data blocks

## Blocks

### Provider blocks

Terraform is a cloud agnostic infrastructure as code tool, which means that it can be used across various different cloud providers (AWS, GCP and Azure among others).

To work with a given cloud provider, Terraform needs to install a plugin for that provider.
Plugins are available in the [Terraform Registry](https://registry.terraform.io/browse/providers){target=_blank}.

Use provider blocks to configure provider plugins:

```terraform
provider "<provider>" {
  <argument> = <value>
}
```

For example, to configure the [Azure provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest){target=_blank} plugin:

```terraform
provider "azurerm" {
  features {}
}
```

### Resource blocks

Use resource blocks to create new resources:

```terraform
resource "<provider>_<resource>" "<name>" {
  <argument> = <value>
}
```

For example:

```terraform
resource "azurerm_storage_account" "example" {
  name                     = "examplest"
  resource_group_name      = "example-rg"
  location                 = "northeurope"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
```

### Data blocks

Use data blocks to read an existing resource:

```terraform
data "<provider>_<resource>" "<name>" {
  <argument> = <value>
}
```

For example:

```terraform
data "azurerm_resource_group" "example" {
  name = "example-rg"
}
```

## References

Blocks can reference arguments and attributes from other blocks.

For example:

```terraform
data "azurerm_resource_group" "example" {
  name = "example-rg"
}

resource "azurerm_storage_account" "example" {
  name                     = "examplest"
  resource_group_name      = data.azurerm_resource_group.example.name
  location                 = data.azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
```

Now that we're familiar with the Terraform block types and references, let's start creating some resources!
