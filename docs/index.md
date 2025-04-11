# Equinor Terraform Baseline

Equinor Terraform Baseline (ETB) is:

- A set of best practices for creating reusable Terraform modules using the Azure provider.
- A library of reusable Terraform modules that have been created using these best practices.

ETB is currently written as an extension of [Terraform Best Practices](https://www.terraform-best-practices.com), however the long-term goal is for ETB to be a complete replacement.

Before using ETB, you should be familiar with the following pages from the official Terraform documentation:

- [Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
- [Style Guide](https://developer.hashicorp.com/terraform/language/style)
- [Version Constraints](https://developer.hashicorp.com/terraform/language/expressions/version-constraints)
- [Publishing Modules](https://developer.hashicorp.com/terraform/registry/modules/publish)

## Core principles

The best practices defined by the Terraform baseline are based on a set of core principles:

- **Simplicity:** The contents of a module should be *minimal* and *simple*.
- **Consistency**: A module should follow *consistent* naming conventions, coding standards and structure.
- **Reusability**: A module should be designed to be *reusable* across different projects and environments.
- **Transparency**: The purpose of a module should be *clear* and *well-documented*.
- **Predictability**: The behavior of a module should be *predictable*.
- **Security**: A module should follow *security best practices* to minimize risks.
- **Maintainability**: A module should be easy to maintain with minimal technical depth.

## Usage

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
