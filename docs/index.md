# Equinor Terraform Baseline

## Introduction

Equinor Terraform Baseline is:

- A set of best practices for creating reusable Terraform modules using the Azure provider.
- A library of reusable Terraform modules that have been created using these best practices.

## Creating modules

Before creating a module, you should be familiar with the following pages from the official Terraform documentation:

- [Style Guide](https://developer.hashicorp.com/terraform/language/style)
- [Publishing Modules](https://developer.hashicorp.com/terraform/registry/modules/publish)

When creating a module, be sure to follow our [best practices](./best-practices/repository.md).

## Using modules

Call a module by using the following syntax:

```terraform
provider "azurerm" {
  features {}
}

module "example" {
  source  = "equinor/<module>/azurerm"
  version = "<version>"

  # insert inputs here
}
```

`<module>` is the name of a module in the [module library](https://registry.terraform.io/search/modules?namespace=equinor), and `<version>` is the specific version of that module to be installed.

The documentation for each module lists the available versions and inputs.

### Version updates

Use [Dependabot](https://docs.github.com/en/code-security/dependabot/dependabot-version-updates/about-dependabot-version-updates) to keep modules you use updated to the latest versions.

Create a Dependabot configuration file `.github/dependabot.yml` in your repository containing the following configuration:

```yaml
version: 2
updates:
  - package-ecosystem: terraform
    directories: [/terraform/**/*]
    groups:
      terraform:
        patterns: ["*"]
```
