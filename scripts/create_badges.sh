#! /bin/bash
#
# In a logical order:
# 1. Blue: latest release
# 2. Bright green: community stats (downloads and contributors)
# 3. Yellow: maintenance stats (issues and pull requests)
# 4. Green: license

set -eu

module_name="$1"
provider="${2:-"azurerm"}"

namespace="equinor"
repo="$namespace/terraform-${provider}-${module_name}"
module="$namespace/$module_name/$provider"
badges="
[![GitHub Release](https://img.shields.io/github/v/release/$repo?color=blue)](https://github.com/$repo/releases/latest)
[![Terraform Module Downloads](https://img.shields.io/terraform/module/dt/$module?color=brightgreen)](https://registry.terraform.io/modules/$module/latest)
[![GitHub contributors](https://img.shields.io/github/contributors/$repo?color=brightgreen)](https://github.com/$repo/graphs/contributors)
[![GitHub Issues](https://img.shields.io/github/issues/$repo?color=yellow)](https://github.com/$repo/issues)
[![GitHub Pull requests](https://img.shields.io/github/issues-pr/$repo?color=yellow)](https://github.com/$repo/pulls)
[![GitHub License](https://img.shields.io/github/license/$repo?color=green)](https://github.com/$repo/blob/main/LICENSE)
"

echo "$badges"
