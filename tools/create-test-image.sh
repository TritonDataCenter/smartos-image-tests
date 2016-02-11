#!/bin/bash

set -euo pipefail
IFS=$'\n\t'


# Load triton config
. triton.cfg

DATE=`date +%Y%m%d`
UUID=
NAME=
TAG='{"testimage": true}'

usage() {
cat << EOF
Usage: $0 <VM UUID>

Create a custom image from <VM UUID>

EOF
exit 1
}

createimage() {
  machinedetails=$(triton -p ${TRITON_PROFILE} instance get $VM | json -a id name)
  uuid=$(echo $machinedetails | cut -d ' ' -f1)
  name=$(echo $machinedetails | cut -d ' ' -f2)
  triton -p ${TRITON_PROFILE} image create -t $TAG -w $uuid $name-custom-image $DATE
}

if [ $# -eq 0 ]; then
  usage
fi

VM=$1

createimage
