# Scripts

This directory contains scripts that will help you create reusable Terraform modules.

## Prerequisites

- Install [GitHub CLI](https://cli.github.com)

## Usage

Change to the `scripts` directory:

```console
cd scripts/
```

Create GitHub repository:

```console
./create_github_repo.sh <module_name>
```

For example:

```console
./create_github_repo.sh storage
```

Configure GitHub repository:

```console
./configure_github_repo.sh <module_name>
```
