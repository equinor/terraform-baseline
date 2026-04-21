---
name: terraform-baseline-builder
description: "Generate, review, and refactor Terraform modules and configurations following Equinor Terraform Baseline and HashiCorp best practices. USE FOR: create Terraform module, scaffold module, write Terraform code, review Terraform, refactor Terraform, create variables, create outputs, create resources, Terraform best practices, module structure, naming conventions, Azure Terraform module. DO NOT USE FOR: deploying infrastructure, running terraform apply/plan, CI/CD pipeline setup."
---

# Terraform Baseline Builder

This skill helps generate, review, and refactor Terraform modules and configurations that follow the **Equinor Terraform Baseline** and **HashiCorp official best practices**.

Apply this skill whenever the user asks to write, review, scaffold, or refactor Terraform code.

---

## Core Principles

All generated Terraform code MUST adhere to these principles:

- **Simplicity:** Module contents should be minimal and simple.
- **Consistency:** Follow consistent naming conventions, structure, and coding standards.
- **Reusability:** Design modules to be reusable across different projects and environments.
- **Transparency:** Purpose should be clear and well-documented.
- **Predictability:** Module behavior should be predictable.
- **Security:** Follow security best practices (e.g., Microsoft security recommendations for Azure resources).
- **Maintainability:** Easy to maintain with minimal technical debt.

---

## Module Structure (Standard)

Every module MUST follow the HashiCorp standard module structure:

```
.
├── README.md
├── main.tf          # Primary entrypoint; all resource/data blocks (or nested module calls)
├── variables.tf     # All variable blocks, in alphabetical order
├── outputs.tf       # All output blocks, in alphabetical order
├── terraform.tf     # Single terraform block: required_version + required_providers
├── locals.tf        # Local values (if referenced across multiple files)
├── modules/         # Nested submodules (optional)
│   └── <submodule>/
│       ├── README.md
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── examples/        # Usage examples (optional)
│   └── <example>/
│       └── main.tf
└── test/            # Automated tests (optional)
```

### File Rules

- `main.tf` is the primary entrypoint. For simple modules, all resources go here. For complex modules, split by logical group (e.g., `network.tf`, `storage.tf`, `compute.tf`).
- `variables.tf` and `outputs.tf` MUST exist even if empty.
- `terraform.tf` contains ONLY the `terraform` block with `required_version` and `required_providers`.
- Use a separate `providers.tf` only if provider configuration is complex (e.g., aliasing).
- `locals.tf` for local values referenced in multiple files. File-specific locals go at the top of that file.

---

## Naming Conventions

### Repository Naming

- Use the convention `terraform-<PROVIDER>-<NAME>` (e.g., `terraform-azurerm-key-vault`).
- For Azure modules, name after the corresponding Azure CLI group or subgroup (e.g., `storage`, `key-vault`, `log-analytics`).
- Separate words with `-` consistently.

### Resource Naming

- Use descriptive **nouns** for resource names.
- Do **NOT** include the resource type in the name (the address already includes it).
- Separate words with **underscores**.
- Wrap resource type and name in double quotes.
- Use `this` as the name when a module creates a single instance of its main resource.

```terraform
# BAD
resource "azurerm_storage_account" "storage_account_main" { ... }

# GOOD
resource "azurerm_storage_account" "this" { ... }
```

### Variable and Output Naming

- Variables: `<resource>_<block>_<argument>` (e.g., `account_replication_type`)
- Outputs: `<resource>_<block>_<attribute>` (e.g., `account_id`)
- **Exception:** Omit the module name from variable/output names. In module `storage`, use `account_name` not `storage_account_name`.

---

## Variables

### Declaration Rules

- All resource arguments MUST be exposed as variables.
- ALWAYS include `type` and `description` for every variable.
- If the variable is optional, define a reasonable `default`.
- For sensitive variables, set `sensitive = true`.
- Prefer simple types (`string`, `number`, `bool`) over complex types where possible.

### Parameter Order (within a variable block)

```terraform
variable "example" {
  type        = string
  description = "Description of the variable."
  default     = "value"       # optional
  sensitive   = true          # optional
  nullable    = false         # optional

  validation {                # optional
    condition     = ...
    error_message = "..."
  }
}
```

### Description Conventions

When valid values are known, append to the description:

- Exact set known: `Value must be "X" or "Y".`
- Range known: `Value must be between X and Y.`
- Subset known: `Possible values include X, Y, and Z.`
- Format known: `Value must be in F format, e.g. X, Y, and Z.`

Always add `validation` blocks for known value constraints:

```terraform
variable "kind" {
  type        = string
  description = "The kind of Web App to create. Value must be \"Linux\" or \"Windows\"."
  default     = "Linux"

  validation {
    condition     = contains(["Linux", "Windows"], var.kind)
    error_message = "Kind must be \"Linux\" or \"Windows\"."
  }
}
```

---

## Outputs

### Declaration Rules

- All resource attributes MUST be exposed as outputs.
- ALWAYS include a `description` for every output.

### Parameter Order (within an output block)

```terraform
output "example_id" {
  description = "The ID of the example resource."
  value       = azurerm_example.this.id
  sensitive   = false  # optional
}
```

---

## Resources

### General Rules

- Configure resources based on provider security recommendations (e.g., Microsoft security recommendations for Azure).
- Use resources that do not require more than `Contributor` role at the resource group scope.
- Do NOT create resources that are automatically created by the provider (e.g., Azure hidden resources like the `master` database for SQL Server).
- A module should only perform **control plane** operations, not data plane operations.

### Single Resource per Module

- A single module call should create a single instance of the main resource.
- A module should NOT create just a single resource unless that resource requires complex configuration.

### Submodules

If a resource is a child of another resource:
- The parent resource should be a **module**.
- The child resource should be a **submodule** under `modules/`.
- Reference as `module//modules/<child>`.

### Resource Parameter Order

```terraform
resource "azurerm_example" "this" {
  # 1. count or for_each (meta-arguments first)
  count = var.enable ? 1 : 0

  # 2. Resource-specific non-block parameters
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  # 3. Resource-specific block parameters
  site_config {
    # ...
  }

  # 4. Lifecycle block
  lifecycle {
    prevent_destroy = true
  }

  # 5. depends_on
  depends_on = [azurerm_resource_group.this]
}
```

---

## Conditional Resources (0 or 1)

Use `count` with a conditional expression based on a static value (variable or local):

```terraform
variable "kind" {
  type        = string
  description = "The kind of Web App. Value must be \"Linux\" or \"Windows\"."
  default     = "Linux"

  validation {
    condition     = contains(["Linux", "Windows"], var.kind)
    error_message = "Kind must be \"Linux\" or \"Windows\"."
  }
}

resource "azurerm_linux_web_app" "this" {
  count = var.kind == "Linux" ? 1 : 0
  # ...
}

resource "azurerm_windows_web_app" "this" {
  count = var.kind == "Windows" ? 1 : 0
  # ...
}
```

---

## Repeatable Resources (0 or more)

Use `for_each` with a variable of type `map(object({}))`. Default to `{}` for no resources:

```terraform
variable "firewall_rules" {
  description = "A map of firewall rules to create."

  type = map(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))

  default = {}
}

resource "azurerm_mssql_firewall_rule" "this" {
  for_each = var.firewall_rules

  name             = each.value.name
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address
}
```

---

## Dynamic Blocks

### Repeatable Nested Blocks (0 or more)

Use `list(object({}))` with `dynamic` blocks. Default to `[]`:

```terraform
variable "auth_settings_active_directory" {
  description = "A list of Active Directory authentication settings."

  type = list(object({
    client_id                  = string
    client_secret_setting_name = string
  }))

  default = []
}

resource "azurerm_linux_web_app" "this" {
  # ...

  auth_settings {
    enabled = length(var.auth_settings_active_directory) == 0 ? false : true

    dynamic "active_directory" {
      for_each = var.auth_settings_active_directory

      content {
        client_id                  = active_directory.value["client_id"]
        client_secret_setting_name = active_directory.value["client_secret_setting_name"]
      }
    }
  }
}
```

### Non-Repeatable Nested Blocks (0 or 1)

Use `object()` with a `null` default. Wrap in `[val]` or `[]` for the `for_each`:

```terraform
variable "blob_properties" {
  description = "The blob properties for this storage account."

  type = object({
    versioning_enabled  = optional(bool, true)
    change_feed_enabled = optional(bool, true)
  })

  default = {}
}

resource "azurerm_storage_account" "this" {
  # ...

  dynamic "blob_properties" {
    for_each = var.blob_properties != null ? [var.blob_properties] : []

    content {
      versioning_enabled  = blob_properties.value["versioning_enabled"]
      change_feed_enabled = blob_properties.value["change_feed_enabled"]
    }
  }
}
```

**Exceptions** for non-repeatable blocks:
- Blocks defined as required by the provider (e.g., `site_config` on `azurerm_linux_web_app`).
- Blocks that are optional but have an argument to enable/disable (e.g., `auth_settings` with `enabled`).

---

## Meta-Arguments

### Lifecycle

- Use `prevent_destroy = true` on **stateful resources** (databases, storage) to prevent accidental data loss.
- Use `ignore_changes` **sparingly** — heavy use leads to configuration drift.

### count vs for_each

- Use `count` for conditional creation (0 or 1) based on a boolean/string.
- Use `for_each` for repeatable resources where each instance needs distinct values.
- Place `count` or `for_each` as the **first** argument in the resource block.

---

## Code Formatting and Style

- Run `terraform fmt` before committing.
- Run `terraform validate` to check syntax.
- Use `#` for all comments (not `//` or `/* */`).
- Indent **two spaces** per nesting level.
- Align `=` signs for consecutive single-line arguments at the same nesting level.
- Separate top-level blocks with **one blank line**.
- Place meta-arguments (`count`, `for_each`) first, then arguments, then nested blocks, then `lifecycle`, then `depends_on`.
- Let code "build on itself" — define data sources before the resources that reference them.

---

## Version Pinning

- Pin provider versions in `required_providers`:

```terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.9"
}
```

- Pin module sources to a specific ref or version:

```terraform
module "storage" {
  source = "github.com/equinor/terraform-azurerm-storage?ref=v12.1.1"
  # ...
}
```

- Use [Dependabot](https://docs.github.com/en/code-security/dependabot/dependabot-version-updates/about-dependabot-version-updates) to keep module versions up to date.

---

## .gitignore

Always commit:
- All `.tf` files
- `.terraform.lock.hcl` (dependency lock file)
- `.gitignore`
- `README.md`

Never commit:
- `terraform.tfstate` and `terraform.tfstate.*`
- `.terraform.tfstate.lock.info`
- `.terraform/` directory
- Saved plan files
- `.tfvars` files containing sensitive information

---

## Testing

- Write automated tests for all variants of the resources using [Terraform native tests](https://developer.hashicorp.com/terraform/language/tests) (`terraform test`).
- Place test files in a `tests/` directory with the `.tftest.hcl` extension.
- Run tests in CI (e.g., as a pre-merge check in pull requests).

---

## Module Composition

- Keep the module tree **flat** — prefer one level of child modules.
- Use **dependency inversion**: pass dependencies as input variables rather than having modules create their own.
- Use **data-only modules** to encapsulate data source lookups when the retrieval method may change.

---

## Security

- Configure resources based on provider security recommendations.
- Use `sensitive = true` for variables containing secrets.
- Never hardcode credentials — use environment variables or a secrets manager.
- Use dynamic provider credentials when possible.
- Modules should only perform control plane operations (not data plane) to avoid firewall workarounds that lower security.

---

## Checklist

Before submitting Terraform code, verify:

- [ ] Follows standard module structure (`main.tf`, `variables.tf`, `outputs.tf`, `terraform.tf`)
- [ ] All arguments exposed as variables with `type`, `description`, and `validation` where applicable
- [ ] All attributes exposed as outputs with `description`
- [ ] Resource names use underscores and descriptive nouns (no resource type in the name)
- [ ] `terraform fmt` passes
- [ ] `terraform validate` passes
- [ ] `prevent_destroy` set on stateful resources
- [ ] Provider and module versions are pinned
- [ ] `.gitignore` excludes state files, `.terraform/`, and sensitive `.tfvars`
- [ ] Security recommendations followed (no hardcoded credentials, `sensitive = true` where needed)
- [ ] Conditional resources use `count`; repeatable resources use `for_each` with `map(object({}))`
- [ ] Dynamic blocks follow the correct pattern (list for repeatable, nullable object for non-repeatable)
