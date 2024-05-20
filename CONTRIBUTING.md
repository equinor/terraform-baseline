# Contributing guidelines

This document gives an overview of how to contribute to Terraform Baseline repositories.

## 💡 Requesting changes

Open an issue in [this repository](https://github.com/equinor/terraform-baseline/issues/new/choose).

## 📝 Making changes

1. Create a new branch. For external contributors, create a fork.
1. Commit your changes.
1. Create a pull request (PR).
1. If a relevant issue exists, [link your PR to that issue](https://docs.github.com/en/issues/tracking-your-work-with-issues/linking-a-pull-request-to-an-issue).

## ✅ Reviewing changes

1. If any resources are added or updated, ensure that they follow the [best practices for resources](docs/best-practices/resources.md).
1. If any variables are added or updated, ensure that they follow the [best practices for variables](docs/best-practices/variables-and-outputs.md).
1. If any outputs are added or updated, ensure that they follow the [best practices for outputs](docs/best-practices/variables-and-outputs.md).
1. If any meta-arguments (`count`, `for_each`) or -blocks (`lifecycle`) are used, ensure that they follow the [best practices for meta-arguments](docs/best-practices/meta-arguments.md).
1. Check if there are any **breaking changes** that will require users to update their module calls:

     - Add variable without default value.
     - Update variable type.
     - Update output value.
     - Rename variable or output.
     - Remove variable or output.
     - Remove `moved` block.

1. Ensure that the PR title follows the [Conventional Commits specificiation](https://www.conventionalcommits.org/en/v1.0.0/) and is using one of the following allowed types:

      - **feat:** add or remove something (resource, argument, nested block, variable or output)
      - **fix:** fix something broken
      - **refactor:** change something without adding, removing or fixing anything
      - **docs:** document something
      - **chore:** everything else

## 🤝 Roles and responsibilities

This section describes the various roles and responsibilities in the Terraform Baseline project.

### 🦸‍♀️ External contributors

An external contributor should:

- Create forks of Terraform Baseline repositories.
- Create issues and pull requests in Terraform Baseline repositories.

### 👨‍🎓 Contributors

A contributor must:

- Be a member of the [@equinor/terraform-baseline](https://github.com/orgs/equinor/teams/terraform-baseline) team.
- Actively contribute to one or more Terraform Baseline repositories.

A contributor should:

- Have basic understanding of Terraform.
- Have basic understanding of Terraform Baseline best practices.
- Create module repositories.

### 👷‍♀️ Maintainers

A maintainer must:

- Be a member of the [@equinor/terraform-baseline-maintainers](https://github.com/orgs/equinor/teams/terraform-baseline-maintainers) team.
- Review and approve pull requests in all Terraform Baseline repositories.
- Discuss and update best practices when needed.

A maintainer should:

- Have complete understanding of Terraform.
- Have complete understanding of Terraform Baseline best practices.
- Communicate and share with other maintainers.

### 👮‍♂️ Administrators

An administrator must:

- Be a member of the [@equinor/terraform-baseline-admins](https://github.com/orgs/equinor/teams/terraform-baseline-admins) team.

An administrator should:

- Configure module repositories.
- Publish modules to Terraform Registry.
- Archive deprecated module repositories.
- Recruit people to the above roles 🤗
