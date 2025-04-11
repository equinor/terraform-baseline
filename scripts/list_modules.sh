#! /bin/bash

# List all Terraform Baseline modules as GitHub flavored Markdown checkboxes.
# Useful when creating Issues that require updating all module repositories.
#
# Prerequisites:
#   gh

set -eu

readarray -t repos <<< "$(gh repo list equinor --topic terraform-module,terraform-baseline --json nameWithOwner,homepageUrl | jq -c .[])"

for repo in "${repos[@]}"; do
  repo_name=$(echo "$repo" | jq -r .nameWithOwner)
  namespace=$(echo "$repo_name" | cut -d / -f 1)
  provider=$(echo "$repo_name" | cut -d - -f 2)
  module_name=$(echo "$repo_name" | cut -d - -f 3-)
  module_url=$(echo "$repo" | jq -r .homepageUrl)
  echo "- [ ] [$namespace/$module_name/$provider]($module_url)"
done
