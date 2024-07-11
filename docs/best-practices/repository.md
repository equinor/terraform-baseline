# Repository

- Use [this template](https://github.com/equinor/terraform-module-template) when creating your repository.

- Use the common naming convention `terraform-azurerm-<module>` when naming your repository, where `<module>` is the name of the module.

    Modules should be named after the corresponding Azure CLI group or subgroup, for example:

    - Terraform module [`key-vault`](https://registry.terraform.io/modules/equinor/key-vault/azurerm/latest) corresponds to Azure CLI group [`keyvault`](https://learn.microsoft.com/en-us/cli/azure/keyvault?view=azure-cli-latest).

    - Terraform module [`storage`](https://registry.terraform.io/modules/equinor/storage/azurerm/latest) corresponds to Azure CLI group [`storage`](https://learn.microsoft.com/en-us/cli/azure/storage?view=azure-cli-latest).

    - Terraform module [`log-analytics`](https://registry.terraform.io/modules/equinor/log-analytics/azurerm/latest) corresponds to Azure CLI subgroup [`log-analytics`](https://learn.microsoft.com/en-us/cli/azure/monitor/log-analytics?view=azure-cli-latest).

!!! note
    Azure CLI uses inconsistent separation of words in group names. We choose to consistenly separate words by `-` in module names.

- Configure the following accesses for the repository:

    | Team | Role |
    | --- | --- |
    | @equinor/terraform-baseline | `Write` |
    | @equinor/terraform-baseline-admins | `Admin` |
    | @equinor/terraform-baseline-maintainers | `Maintain` |

- Configure the following code owners in a file `.github/CODEOWNERS`:

    ```raw
    * @equinor/terraform-baseline-maintainers

    **/CODEOWNERS @equinor/terraform-baseline-admins
    ```

- Add topics `terraform-baseline` and `terraform-module` to the repository.
