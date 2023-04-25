# Other

- The `prevent_destroy` [lifecycle meta-argument](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle) should be used sparingly. A [`CanNotDelete` lock](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources) should be used instead.
