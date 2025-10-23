#! /bin/bash
#
# Create badges for Terraform module README.
#
# Creates badges in a logical order:
#   1. Latest release
#   2. License
#   3. Downloads
#   4. Community and maintenance (contributors, issues and pull requests)

set -eu

module_name="$1"
provider="${2:-"azurerm"}"

namespace="equinor"
repo="$namespace/terraform-${provider}-${module_name}"
module="$namespace/$module_name/$provider"
label="$namespace%2F$module_name%2F$provider"
badges="
[![GitHub Release](https://img.shields.io/github/v/release/$repo)](https://github.com/$repo/releases/latest)
[![GitHub License](https://img.shields.io/github/license/$repo?color=blue)](https://github.com/$repo/blob/main/LICENSE)
[![Terraform Module Downloads](https://img.shields.io/terraform/module/dt/$module)](https://registry.terraform.io/modules/$module/latest)
[![GitHub contributors](https://img.shields.io/github/contributors/$repo)](https://github.com/$repo/graphs/contributors)
[![GitHub Issues by label](https://img.shields.io/github/issues/equinor/terraform-baseline/$label?label=issues)](https://github.com/equinor/terraform-baseline/issues?q=is:issue%20state%3Aopen%20label%3A$label)
[![GitHub Pull requests](https://img.shields.io/github/issues-pr/$repo)](https://github.com/$repo/pulls)
"

echo "$badges"
