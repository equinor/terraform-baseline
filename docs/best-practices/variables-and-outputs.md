# Variables and outputs

- All arguments should be made available as variables.
- All attributes should be made available as outputs.
- Variables and outputs should follow a common naming convention `<resource>_<block>_<argument|attribute>`.
    - **Known exception:** Variable and output names that contain the module name. For example, in module `storage` the variable `storage_account_name` should be named `account_name` instead.
- Use description to describe the values of variables and outputs.
- If valid variable values is known:
    - Append to description:
        - If set of valid values is known: `Value must be X or Y.`
        - If range of valid values is known: `Value must be between X and Y.`
        - If subset of valid values is known: `Possible values include X, Y and Z.`
        - If format of valid values is known: `Value must be in F format, e.g. X, Y and Z.`
    - Add [custom validation rules](https://developer.hashicorp.com/terraform/language/values/variables#custom-validation-rules).
- Use simple variable types (`string`, `number` and `bool`) over complex variable types (`list`, `object` and `map`) where possible.
