#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# Load triton config
. triton.cfg

echo "Current list of custom images:"
triton -p ${TRITON_PROFILE} image list public=false | grep "\-custom-image"