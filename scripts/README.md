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

## Bulk update repositories

Run the script `bulk_update_repos.sh` to bulk update all repositories with topic `terraform-baseline`:

```console
./bulk_update_repos.sh <SCRIPT_PATH> <BRANCH_NAME> <COMMIT_MESSAGE>
```

It will do the following for each repository:

1. Clone the repository.
1. Run the script at path `<SCRIPT_PATH>`.
1. Commit and push the changes to branch `<BRANCH_NAME>` with message `<COMMIT_MESSAGE>`.
1. Create a pull request.
1. Delete the local repository.

For example, create a script `test.sh` that appends the word `test` to the end of the `README` file:

```bash
#! /bin/bash

echo "test" >> README.md
```

Make the script executable:

```console
chmod +x test.sh
```

Run the bulk update script to append the word `test` to the end of the `README` file for each module repository:

```console
./bulk_update_repos.sh test.sh docs-append-test-to-readme "docs: append test to README"
```
