# Terraform Baseline

[![GitHub License](https://img.shields.io/github/license/equinor/terraform-baseline)](https://github.com/equinor/terraform-baseline/blob/main/LICENSE)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)
[![SCM Compliance](https://scm-compliance-api.radix.equinor.com/repos/equinor/terraform-baseline/badge)](https://developer.equinor.com/governance/scm-policy/)

Terraform Baseline is:

- 📝 A set of best practices for creating reusable Terraform modules using the Azure provider.
- 📚 A library of reusable Terraform modules that have been created using these best practices.

Hosted in [GitHub Pages](https://equinor.github.io/terraform-baseline/).

## Development

### Windows

1. Install Python:

    ```console
    winget install --id "Python.Python.3.12" -e
    ```

1. Restart your machine to complete the installation.

1. Create and activate virtual environment:

    ```console
    python -m venv "venv"
    . "venv\Scripts\activate"
    ```

1. Install requirements:

    ```console
    python -m pip install --upgrade pip
    pip install -r "requirements.txt"
    ```

1. Run development server:

    ```console
    mkdocs serve
    ```

### Container

1. Read [this document](https://code.visualstudio.com/docs/devcontainers/containers).

1. Open this repository in the development container.

1. Run the development server:

    ```console
    mkdocs serve
    ```

## Contributing

See [Contributing guidelines](CONTRIBUTING.md).

## License

This project is licensed under the terms of the [MIT license](LICENSE).
