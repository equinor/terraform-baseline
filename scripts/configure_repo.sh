#!/bin/bash

set -eu

module_name=$1

repo="equinor/terraform-azurerm-$module_name"
default_branch="main"

gh repo edit "$repo" \
  --homepage "https://registry.terraform.io/modules/equinor/$module_name/azurerm/latest" \
  --add-topic "terraform-baseline" \
  --enable-wiki=false \
  --enable-issues=false \
  --enable-projects=false \
  --default-branch="$default_branch" \
  --delete-branch-on-merge=true \
  --enable-merge-commit=false \
  --enable-squash-merge=true \
  --enable-rebase-merge=false \
  --allow-update-branch=false \
  --enable-auto-merge=false

# Set branch protection rules for default branch

gh api "repos/$repo/branches/$default_branch/protection" \
  --method PUT \
  --input "branch_protection.json"
