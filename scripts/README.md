# Scripts

This directory contains scripts that will help you create reusable Terraform modules.

## Prerequisites

- Install [GitHub CLI](https://cli.github.com)

## Usage

Change to the `scripts` directory:

```console
cd scripts/
```

Create a GitHub repository for your Terraform module:

```console
./create_repo.sh <module_name>
```

For example, to create a module named `storage`:

```console
./create_repo.sh storage
```

Configure the repository with the recommended settings:

```console
./configure_repo.sh <module_name>
```
