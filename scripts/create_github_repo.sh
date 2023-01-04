#!/bin/bash

set -eu

module_name=$1

repo="equinor/terraform-azurerm-$module_name"

gh repo create "$repo" \
  --public \
  --template equinor/terraform-module-template \
  # --license "TODO"
  # --description "TODO"
