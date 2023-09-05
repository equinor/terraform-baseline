# Equinor Terraform Baseline

Equinor Terraform Baseline is:

- 💡 A set of best practices for creating reusable Terraform modules using the Azure provider.
- 📚 A library of reusable Terraform modules that have been created using these best practices.

Before using the baseline, you should be familiar with the following pages from the official Terraform documentation:

- [Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
- [Version Constraints](https://developer.hashicorp.com/terraform/language/expressions/version-constraints)
- [Publishing Modules](https://developer.hashicorp.com/terraform/registry/modules/publish)

## Best Practices

- Use [this template](https://github.com/equinor/terraform-module-template) when creating your repository.

- Use the common naming convention `terraform-azurerm-<name>` when naming your repository.
  For example, if you want to create a module named `storage`, the repository should be named `terraform-azurerm-storage`.

- Configure the following accesses for the repository:

  | Team | Role |
  | --- | --- |
  | @equinor/terraform-baseline | `Write` |
  | @equinor/terraform-baseline-admins | `Admin` |

- Configure the following code owners in a file `.github/CODEOWNERS`:

  ```raw
  * @equinor/terraform-baseline
  ```

- Don't create single-resource modules.

- Only create resources that require permissions at the resource group scope or lower.
  If you need to use a higher role, create an example instead.

- All arguments should be made available as variables with sensible default values to make the module as generic as possible.

- Variables and outputs should follow a common naming convention `<resource>_<block>_<argument>`, where `<resource>` and/or `<block>` can be omitted if not applicable.
  Use the `description` argument to document the use case of variables and outputs.

  For example, in module `storage`:

  ```terraform
  variable "account_name" {
    description = "The name of this Storage account."
    type        = string
  }

  variable "diagnostic_setting_name" {
    description = "The name of the diagnostic setting to create for this Storage account."
    type        = string
    default     = "audit-logs"
  }

  resource "azurerm_storage_account" "this" {
    name = var.account_name
  }

  resource "azurerm_monitor_diagnostic_setting" "this" {
    name = var.diagnostic_setting_name
  }
  ```

- A single module call should create a single instance of the main resource created by the module. For example, the `web-app` module should create a single Azure Web App, and the `sql` module should create a single Azure SQL server. This creates a common expectation for the behavior of our modules.

- A module should only perform control plane operations (e.g., managing Storage account or Key vault), not data plane operations (e.g., managing Storage container or Key vault secret). See [control plane and data plane](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/control-plane-and-data-plane) in Microsoft docs.

  Performing data plane operations usually require workarounds for dealing with firewalls when run from an automated pipeline that deviate from the deterministic approach promoted by Terraform (e.g, temporarily disabling firewall or temporarily adding own IP to firewall).
  This may lead to the decision of disabling a resource firewall because it is preventing data plane operations from a pipeline, lowering the security of the resource.

  Data plane operations should be handled outside of Terraform.

  > **Note** Might be irrelevant depending on the implementation of github/roadmap#614.

- Automated tests should be implemented for all variants of the relevant resource using [Terratest](https://terratest.gruntwork.io/). For example, in the `storage` module, automated tests should be implemented for standard GPv2 storage, premium GPv2 storage, standard blob storage, premium block blob storage and premium file storage.

- The `prevent_destroy` [lifecycle meta-argument](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle) should be used sparingly. A [`CanNotDelete` lock](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources) should be used instead.

## Module Library

The latest version of the following modules have been created using ETB:

| Module        | Repository                                                                                            | Latest release                                                                                                                                                                                  |
| ------------- | ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ACR           | [equinor/terraform-azurerm-acr](https://github.com/equinor/terraform-azurerm-acr)                     | [![Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-acr?display_name=tag&sort=semver)](https://github.com/equinor/terraform-azurerm-acr/releases)                     |
| App Config    | [equinor/terraform-azurerm-app-config](https://github.com/equinor/terraform-azurerm-app-config)       | [![Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-app-config?display_name=tag&sort=semver)](https://github.com/equinor/terraform-azurerm-app-config/releases)       |
| App Insights  | [equinor/terraform-azurerm-app-insights](https://github.com/equinor/terraform-azurerm-app-insights)   | [![Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-app-insights?display_name=tag&sort=semver)](https://github.com/equinor/terraform-azurerm-app-insights/releases)   |
| App Service   | [equinor/terraform-azurerm-app-service](https://github.com/equinor/terraform-azurerm-app-service)     | [![Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-app-service?display_name=tag&sort=semver)](https://github.com/equinor/terraform-azurerm-app-service/releases)     |
| Automation    | [equinor/terraform-azurerm-automation](https://github.com/equinor/terraform-azurerm-automation)       | [![Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-automation?display_name=tag&sort=semver)](https://github.com/equinor/terraform-azurerm-automation/releases)       |
| Container     | [equinor/terraform-azurerm-container](https://github.com/equinor/terraform-azurerm-container)         | [![Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-container?display_name=tag&sort=semver)](https://github.com/equinor/terraform-azurerm-container/releases)         |
| Databricks    | [equinor/terraform-azurerm-databricks](https://github.com/equinor/terraform-azurerm-databricks)       | [![Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-databricks?display_name=tag&sort=semver)](https://github.com/equinor/terraform-azurerm-databricks/releases)       |
| Event Grid    | [equinor/terraform-azurerm-event-grid](https://github.com/equinor/terraform-azurerm-event-grid)       | [![Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-event-grid?display_name=tag&sort=semver)](https://github.com/equinor/terraform-azurerm-event-grid/releases)       |
| Function App  | [equinor/terraform-azurerm-function-app](https://github.com/equinor/terraform-azurerm-function-app)   | [![Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-function-app?display_name=tag&sort=semver)](https://github.com/equinor/terraform-azurerm-function-app/releases)   |
| Grafana       | [equinor/terraform-azurerm-grafana](https://github.com/equinor/terraform-azurerm-grafana)             | [![Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-grafana?display_name=tag&sort=semver)](https://github.com/equinor/terraform-azurerm-grafana/releases)             |
| Identity      | [equinor/terraform-azurerm-identity](https://github.com/equinor/terraform-azurerm-identity)           | [![Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-identity?display_name=tag&sort=semver)](https://github.com/equinor/terraform-azurerm-identity/releases)           |
| Key Vault     | [equinor/terraform-azurerm-key-vault](https://github.com/equinor/terraform-azurerm-key-vault)         | [![Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-key-vault?display_name=tag&sort=semver)](https://github.com/equinor/terraform-azurerm-key-vault/releases)         |
| Log Analytics | [equinor/terraform-azurerm-log-analytics](https://github.com/equinor/terraform-azurerm-log-analytics) | [![Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-log-analytics?display_name=tag&sort=semver)](https://github.com/equinor/terraform-azurerm-log-analytics/releases) |
| Network       | [equinor/terraform-azurerm-network](https://github.com/equinor/terraform-azurerm-network)             | [![Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-network?display_name=tag&sort=semver)](https://github.com/equinor/terraform-azurerm-network/releases)             |
| Postgres      | [equinor/terraform-azurerm-postgres](https://github.com/equinor/terraform-azurerm-postgres)           | [![Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-postgres?display_name=tag&sort=semver)](https://github.com/equinor/terraform-azurerm-postgres/releases)           |
| Service Bus   | [equinor/terraform-azurerm-service-bus](https://github.com/equinor/terraform-azurerm-service-bus)     | [![Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-service-bus?display_name=tag&sort=semver)](https://github.com/equinor/terraform-azurerm-service-bus/releases)     |
| SQL           | [equinor/terraform-azurerm-sql](https://github.com/equinor/terraform-azurerm-sql)                     | [![Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-sql?display_name=tag&sort=semver)](https://github.com/equinor/terraform-azurerm-sql/releases)                     |
| Storage       | [equinor/terraform-azurerm-storage](https://github.com/equinor/terraform-azurerm-storage)             | [![Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-storage?display_name=tag&sort=semver)](https://github.com/equinor/terraform-azurerm-storage/releases)             |
| Web App       | [equinor/terraform-azurerm-web-app](https://github.com/equinor/terraform-azurerm-web-app)             | [![Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-web-app?display_name=tag&sort=semver)](https://github.com/equinor/terraform-azurerm-web-app/releases)             |
