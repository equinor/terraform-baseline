# Variables and outputs

## General

- All arguments should be made available as variables.
- All attributes should be made available as outputs.

## Variable and output names

- Variables should follow a common naming convention:

     ```plaintext
     <resource>_<block>_<argument>
     ```

- Outputs should follow a common naming convetion:

     ```plaintext
     <resource>_<block>_<attribute>
     ```

    !!! info "Exception"
        Variable and output names that contain the module name. For example, in module `storage` the variable `storage_account_name` should be named `account_name` instead.

## Variable and output descriptions

- Use description to describe the values of variables and outputs.
- If valid variable values is known:
    1. If set of valid values is known, append to description:

        ```plaintext
        Value must be X or Y.
        ```

        Else, if range of valid values is known, append to description:

          ```plaintext
          Value must be between X and Y.
          ```

        Else, if subset of valid values is known, append to description:

          ```plaintext
          Possible values include X, Y and Z.
          ```

        Else, if format of valid values is known, append to description:

          ```plaintext
          Value must be in F format, e.g. X, Y and Z.
          ```

    1. Add [custom validation rules](https://developer.hashicorp.com/terraform/language/values/variables#custom-validation-rules) to check if variable value is valid.

## Variable and output types

- Use simple types (`string`, `number` and `bool`) over complex types (`list`, `object` and `map`) for variables and outputs where possible:

    !!! abstract "Rationale"
        Variables and outputs of simpler types are easier to write good descriptions for. For example, it's easier to write a good description for a simple `string` than for an `object` with multiple `string` properties. It's also easier for a user to pass a simple `string` to a variable than to construct and pass a complex `object`.
