#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# Load triton config
. triton.cfg

echo "Current list of test VMs:"
triton -p ${TRITON_PROFILE} instance list -o shortid,name,state,primaryIp,tags | grep '"testvm":true'
