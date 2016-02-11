#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# Load triton config
. triton.cfg

testimages=$(triton -p ${TRITON_PROFILE} image list -Ho id public=false name=~"-custom-image")
echo "Deleting all test images..."
triton -p ${TRITON_PROFILE} image delete -f $testimages
