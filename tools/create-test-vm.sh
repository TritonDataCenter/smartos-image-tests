#!/bin/bash

set -euo pipefail
#set -o xtrace

IFS=$'\n\t'

# Load triton config
. triton.cfg

DATE=`date +%Y%m%d-%H%M%S`

usage() {
cat << EOF
Usage: $0 <IMAGE UUID>

Provision a new instance of a given image.

EOF
exit 1
}

IMAGE=
IMAGENAME=
VERSION=
OS=
NAME=
TAG=
TYPE=
UUID=
STATE=
SCRIPT=$PWD/userscript.sh
METADATAFILE="user-data=$PWD/user-data"

getimagedetails() {
  # Pass UUID to get image details for later
  echo -n "Getting image details..."
  IMAGEDETAILS=$(triton -p ${TRITON_PROFILE} image get $1 | json -a name version os type)
  IMAGENAME=$(echo $IMAGEDETAILS | cut -d ' ' -f 1)
  VERSION=$(echo $IMAGEDETAILS | cut -d ' ' -f 2)
  OS=$(echo $IMAGEDETAILS | cut -d ' ' -f 3)
  TYPE=$(echo $IMAGEDETAILS | cut -d ' ' -f 4)
  echo "done."
  echo "$IMAGEDETAILS"
  echo ""
}

setname() {
  NAME="${IMAGENAME}-${VERSION}-${DATE}"
  echo "VM name will be: ${NAME}"
  echo ""
}

createvm() {
  echo "Provisioning VM"
  triton -p ${TRITON_PROFILE} instance create -w -n $NAME -N $PUBLIC_NETWORK -N $PRIVATE_NETWORK -t testvm=true --script=$SCRIPT -M $METADATAFILE $IMAGE $PACKAGE
}

if [ $# -eq 0 ]; then
    usage
fi

IMAGE=$1

getimagedetails $IMAGE
setname
createvm
