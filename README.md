# Equinor Terraform Baseline

[![ci](https://github.com/equinor/terraform-baseline/actions/workflows/ci.yml/badge.svg)](https://github.com/equinor/terraform-baseline/actions/workflows/ci.yml)
[![SCM Compliance](https://scm-compliance-api.radix.equinor.com/repos/equinor/terraform-baseline/badge)](https://scm-compliance-api.radix.equinor.com/repos/equinor/terraform-baseline/badge)

Equinor Terraform Baseline (ETB) is a collection of tutorials on how to get started with Terraform in Equinor.

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
