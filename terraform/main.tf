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
