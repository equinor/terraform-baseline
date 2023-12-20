#! /bin/bash

# Run script for all Terraform Baseline module repositories.
#
# Arguments:
# - Script path
# - Branch name
# - Commit message

set -u

script_path=$1
branch_name=$2
commit_message=$3

owner="equinor"
repos=$(gh repo list "$owner" --visibility public --topic terraform-baseline --limit 999999 --json name --jq .[].name)
root=$(pwd)

for repo in "${repos[@]}"; do
  # Clone repo
  git clone "https://github.com/$owner/$repo.git"
  cd "$repo" || exit

  # Create and switch to new branch
  git switch --create "$branch_name"

  # Run script to make changes
  # shellcheck source=/dev/null
  source "$root/$script_path"

  # Commit all changes
  git add --all
  git commit --message "$commit_message"
  git push

  # Create PR
  gh pr create --title "$commit_message" --body ""

  # Delete local repo
  cd "$root" || exit
  rm -rf "$repo"
done
