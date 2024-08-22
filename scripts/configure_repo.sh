#!/bin/bash

set -eu

module_name=$1
provider=${2:-"azurerm"}

repo="equinor/terraform-$provider-$module_name"
default_branch="main"

gh repo edit "$repo" \
  --homepage "https://registry.terraform.io/modules/equinor/$module_name/$provider/latest" \
  --add-topic "terraform-baseline" \
  --add-topic "terraform-module" \
  --enable-wiki=false \
  --enable-issues=true \
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
