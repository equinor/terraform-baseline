## CONTRIBUTING

This repository is maintained by the [Ops team](https://github.com/orgs/equinor/teams/ops).

We use strict branch protection rules to ensure a [GitOps](https://www.redhat.com/en/topics/devops/what-is-gitops) approach to infrastructure provisioning.

### Steps

1. Create a new branch.
1. Run `terraform init`.
1. Run `terraform validate`.
1. Run `terraform plan`.
1. Commit your changes.
1. Create a pull request to trigger any relevant deployment workflows.
1. Approve deployments.
1. Request a review.
1. Once approved, merge to branch `main`.
