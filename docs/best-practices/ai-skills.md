# AI Skills

## What is the Terraform Baseline Builder skill?

The **Terraform Baseline Builder** is an [AI skill for GitHub Copilot](https://code.visualstudio.com/docs/copilot/copilot-extensibility-overview#_skills){target=_blank} that teaches Copilot the best practices defined by the Terraform Baseline and [HashiCorp's style guide](https://developer.hashicorp.com/terraform/language/style){target=_blank}.

When the skill is active, Copilot will automatically follow these best practices when generating, reviewing, or refactoring Terraform code.

## When to use

Use the skill when working in a **module repository** (e.g. `terraform-azurerm-storage`). Since the modules live in their own separate repositories, the skill provides Copilot with the shared conventions defined in this hub repository.

Common use cases:

- Scaffolding a new module
- Adding variables, outputs, or resources to an existing module
- Reviewing Terraform code for best practice compliance
- Refactoring a module to follow the Terraform Baseline

## Installation

### From this repository

Copy the skill folder into the module repository where you want to use it:

```plaintext
.github/skills/terraform-baseline-builder/SKILL.md
```

!!! note
    The skill file must be placed under `.github/skills/` in the repository where you want Copilot to use it.

### Using a shared configuration

If your organization uses a shared [VS Code profile](https://code.visualstudio.com/docs/editor/profiles){target=_blank} or [Copilot instructions](https://code.visualstudio.com/docs/copilot/copilot-customization){target=_blank}, you can reference the skill from a central location so that all module repositories benefit from it without copying the file.

## What the skill covers

The skill instructs Copilot to follow conventions in the following areas:

| Area | Key points |
| --- | --- |
| **Module structure** | Standard file layout (`main.tf`, `variables.tf`, `outputs.tf`, `terraform.tf`) |
| **Naming** | Repository naming (`terraform-azurerm-<module>`), resource naming (underscores, no type in name), variable/output naming conventions |
| **Variables** | Type, description, defaults, validation blocks, parameter ordering |
| **Outputs** | Description required, parameter ordering |
| **Resources** | Control plane only, single resource per module call, submodule patterns, parameter ordering |
| **Conditional resources** | `count` for 0-or-1 creation |
| **Repeatable resources** | `for_each` with `map(object({}))` |
| **Dynamic blocks** | `list(object({}))` for repeatable, nullable `object()` for non-repeatable |
| **Meta-arguments** | `prevent_destroy` on stateful resources, sparing use of `ignore_changes` |
| **Formatting** | `terraform fmt`, comment style, indentation, argument alignment |
| **Version pinning** | Pin providers and module sources |
| **Testing** | `terraform test` with `.tftest.hcl` files |
| **Security** | No hardcoded credentials, `sensitive = true`, provider security recommendations |

## Example

Asking Copilot to scaffold a new module with the skill active:

> *"Create a new Terraform module for an Azure Key Vault"*

Copilot will generate a module that:

- Uses the standard file layout
- Names the main resource `azurerm_key_vault.this`
- Exposes all arguments as variables with types, descriptions, and validation
- Exposes all attributes as outputs with descriptions
- Follows the correct parameter ordering in all blocks
- Adds `prevent_destroy` if appropriate
- Pins the provider version
