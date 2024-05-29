# Meta-arguments

## Lifecycle

- The [`prevent_destroy` lifecycle meta-argument](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle#prevent_destroy) should be used on stateful resources (e.g. databases) to mitigate the possibility of accidental data loss.
- The [`ignore_changes` lifecycle meta-argument](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle#ignore_changes) should be used sparingly, as heavy use could lead to configuration drift.
