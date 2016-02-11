#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# Load triton config
. triton.cfg

testvms=$(triton -p ${TRITON_PROFILE} instance list -o shortid,name,state,primaryIp,tags | grep '"testvm":true')
echo "Deleting all test VMs..."

for vm in $testvms; do
  uuid=$(echo $vm | cut -d ' ' -f1)
  echo "Deleting $vm..."
  triton -p ${TRITON_PROFILE} instance delete $uuid
done