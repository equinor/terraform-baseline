# Repository

- Use [this template](https://github.com/equinor/terraform-module-template) when creating your repository.

- Use the common naming convention `terraform-azurerm-<name>` when naming your repository.

    For example, if you want to create a module named `storage`, the repository should be named `terraform-azurerm-storage`.

- Configure the following accesses for the repository:

    | Team | Role |
    | --- | --- |
    | @equinor/terraform-baseline | `Write` |
    | @equinor/terraform-baseline-maintainers | `Maintain` |
    | @equinor/terraform-baseline-admins | `Admin` |

- Configure the following code owners in a file `.github/CODEOWNERS`:

    ```raw
    * @equinor/terraform-baseline-maintainers

    **/CODEOWNERS @equinor/terraform-baseline-admins
    ```

- Add topic `terraform-baseline` to the repository.
