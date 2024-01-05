#!/bin/bash

set -eu

module_name=$1

gh repo create "equinor/terraform-azurerm-$module_name" \
  --public \
  --template equinor/terraform-module-template

source ./configure_repo.sh "$module_name"
