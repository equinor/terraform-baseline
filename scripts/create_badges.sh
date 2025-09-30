#! /bin/bash
#
# In a logical order:
# 1. Module status
#     - GitHub release tag
#     - Terraform module downloads
# 2. Community and maintenance
#     - Contributors
#     - Issues
#     - Pull requests
# 3. License

set -eu

module_name=$1
provider=${2:-"azurerm"}

namespace="equinor"
repo="$namespace/terraform-${provider}-${module_name}"
module="$namespace/$module_name/$provider"
badges="
[![GitHub Release](https://img.shields.io/github/v/release/$repo)](https://github.com/$repo/releases/latest)
[![Terraform Module Downloads](https://img.shields.io/terraform/module/dt/$module)](https://registry.terraform.io/modules/$module/latest)
[![GitHub contributors](https://img.shields.io/github/contributors/$repo)](https://github.com/$repo/graphs/contributors)
[![GitHub Issues](https://img.shields.io/github/issues/$repo)](https://github.com/$repo/issues)
[![GitHub Pull requests](https://img.shields.io/github/issues-pr/$repo)](https://github.com/$repo/pulls)
[![GitHub License](https://img.shields.io/github/license/$repo)](https://github.com/$repo/blob/main/LICENSE)
"

echo "$badges"
