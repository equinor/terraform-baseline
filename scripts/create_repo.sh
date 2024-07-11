#!/bin/bash

set -eu

module_name=$1
provider=${2:-"azurerm"}

gh repo create "equinor/terraform-$provider-$module_name" \
  --public \
  --template equinor/terraform-module-template

source ./configure_repo.sh "$module_name"
