#!/usr/bin/env bash

if [[ -n "$TRACE" ]]; then
    export PS4='[\D{%FT%TZ}] ${BASH_SOURCE}:${LINENO}: ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
    set -o xtrace
fi
set -euo pipefail

IFS=$'\n\t'

DATE=`date +%H%M%S`

usage() {
cat <<EOF

Setup test instances and run tests for given image.

Note: This script assumes you have the triton cli command tool setup with a 
      profile for your test environment. Also the script requires you have 
      a RedHat account and a subsciption in order to run some of the tests.

This script will:

    - Create a test instance of the given image with user-script, user-data, 
      a public IP and private IP.
    - Create a custom image of the test instance.
    - Create a test instance from the custom image.
    - Run tests on the above instances.

    Usage:
    
        $0 -i <IMAGE> -p <PROFILE> -n <PROPER_NAME> -d <DESC>
        
    Example:
    
        $0 -i 9d58adc6-499b-11e6-9ea7-437c859dc16b -p us-east-3b -n "minimal-64"
        
    Options:
    
        -i The image you want to test. Can be UUID or image name.
        -p The profile you wish to use. This assumes you have the triton
           CLI tool setup with your desired profile.
        -n The name of the image. This is the proper name found in the 
           /etc/motd and /etc/product files. Should be in quotes.
        -h Show this message

EOF
exit 1
}

IMAGE=
PROFILE=
PROPER_NAME=
PACKAGE=
IMAGENAME=
VERSION=
UUID=
NAME=
TAG="test-instance=true"
UUID=
SCRIPT=$PWD/userscript.sh
METADATAFILE="user-data=$PWD/user-data"

while getopts “hi:p:n:” OPTION
do
  case $OPTION in
    h)
      usage
      exit 1
      ;;
    i)
      IMAGE=$OPTARG
      ;;
    p)
      PROFILE=$OPTARG
      ;;
    n)
      PROPER_NAME=$OPTARG
      ;;
    ?)
      usage
      exit
      ;;
  esac
done

if [[ -z $IMAGE ]] || [[ -z $PROFILE ]] || [[ -z $PROPER_NAME ]]; then
    usage
    exit 1
fi


get_image_details() {
    echo ""
    echo "Getting image details:"
    IMAGEDETAILS=$(triton -p ${PROFILE} image get $1 | json -a name version id)
    IMAGENAME=$(echo $IMAGEDETAILS | cut -d ' ' -f 1)
    VERSION=$(echo $IMAGEDETAILS | cut -d ' ' -f 2)
    UUID=$(echo $IMAGEDETAILS | cut -d ' ' -f 3)
    echo "    $IMAGEDETAILS"
    echo ""
}

choose_package() {

    PACKAGE=$(triton -p ${PROFILE} package list -H memory=512 -o id | head -1)
    echo "Using package:"
    echo "    $PACKAGE"
    echo ""
}

get_networks() {
	echo "Getting networks:"
    
    PUBLIC_NETWORK=$(triton -p ${PROFILE} network list -j | json -ag id -c 'this.public === true' | head -1)
	PRIVATE_NETWORK=$(triton -p ${PROFILE} network list -j | json -ag id -c 'this.public === false' -c 'this.fabric !== true' | head -1)
    
    # Trying using a fabric network instead
    if [[ -z "$PRIVATE_NETWORK" ]]; then
        PRIVATE_NETWORK=$(triton -p ${PROFILE} network list -j | json -ag id -c 'this.public === false' | head -1)
    fi
    
    echo "    Public:  $PUBLIC_NETWORK"
    echo "    Private: $PRIVATE_NETWORK"
    echo ""
}

cat <<USERSCRIPT >userscript.sh
#!/bin/sh

echo "testing user-script" >> /var/tmp/test
hostname $IMAGENAME

USERSCRIPT

cat <<USERDATA >user-data
This is user-data!

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor 
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis 
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore 
eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt 
in culpa qui officia deserunt mollit anim id est laborum.
USERDATA

create_instance() {
    IMAGE=$1
    NAME=$2
    echo "Provisioning:"
    triton -p ${PROFILE} instance create -w -n $NAME -N $PUBLIC_NETWORK -N $PRIVATE_NETWORK -t $TAG --script=$SCRIPT -M $METADATAFILE $IMAGE $PACKAGE
}

wait_for_IP() {
    NAME=$1
    echo "Checking Public IP:"

    while [[ true ]]; do
        echo -n "."
        ping -c1 $(triton -p ${PROFILE} instance ip $NAME) > /dev/null && break;
    done
    sleep 5
    echo ""
    echo "IP is now live."
}

test_image() {
    NAME=$1
    
cat <<PROPYML >properties.yml
$NAME:
  :roles:
    - minimal
  :name: $PROPER_NAME
  :version: $VERSION
  :base_version: $VERSION
  :doc_url: https://docs.joyent.com/images/smartos/minimal
PROPYML

    TARGET_HOST_NAME=$(triton -p ${PROFILE} instance ip $NAME) \
      TARGET_USER_NAME=root rake serverspec

    echo "###########################"
    echo "All minimal tests PASSED."
    echo "###########################"
    echo ""
}

create_custom_image() {
    INSTANCE=$1
    # This is here to workaround a bug where the instance is not stopped properly
    echo "Stopping $INSTANCE"
    triton -p ${PROFILE} instance stop -w $INSTANCE
    echo "Creating custom image of $INSTANCE"
    triton -p ${PROFILE} image create -w -t $TAG $INSTANCE $NAME $VERSION
    echo "Restarting $INSTANCE"
    triton -p ${PROFILE} instance start -w $INSTANCE
}

delete_instance() {
    NAME=$1
    echo "Deleting test instance $NAME"
    triton -p ${PROFILE} instance delete $NAME
}

delete_image() {
    IMAGE=$1
    triton -p ${PROFILE} image delete -f $IMAGE
}

cleanup() {
    echo "Cleaning up."
    
    rm -rf userscript.sh
    rm -rf user-data
    
    unset TARGET_HOST_NAME
    unset TARGET_USER_NAME
    echo "Done."
    echo ""
}

get_image_details $IMAGE
choose_package
get_networks
create_instance $IMAGE ${IMAGENAME}-${VERSION}-${DATE}
wait_for_IP $NAME
test_image $NAME

INSTACE_NAME=$NAME

create_custom_image $INSTACE_NAME

CUSTOM_IMAGE_NAME=$INSTACE_NAME

get_image_details $CUSTOM_IMAGE_NAME
choose_package
get_networks

CUSTOM_INSTANCE_NAME=${IMAGENAME}-${VERSION}-${DATE}-CUSTOM

create_instance $CUSTOM_IMAGE_NAME $CUSTOM_INSTANCE_NAME
wait_for_IP $CUSTOM_INSTANCE_NAME
test_image $CUSTOM_INSTANCE_NAME

echo "Deleting instance and custom image"
ssh-keygen -q -R $(triton -p ${PROFILE} inst ip $INSTACE_NAME)
delete_instance $INSTACE_NAME
ssh-keygen -q -R $(triton -p ${PROFILE} inst ip $CUSTOM_INSTANCE_NAME)
delete_instance $CUSTOM_INSTANCE_NAME
delete_image $CUSTOM_IMAGE_NAME
cleanup

exit 0
