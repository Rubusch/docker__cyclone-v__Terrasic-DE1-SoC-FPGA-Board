#!/bin/bash -e
## resources:
## https://rocketboards.org/foswiki/Documentation/YoctoDoraBuildWithMetaAltera

MY_HOME="$(pwd)"
MY_USER="$(whoami)"

YOCTO_DIR="${MY_HOME}/poky"
BUILD_DIR="${YOCTO_DIR}/build"

for item in ${BUILD_DIR} ${YOCTO_DIR}; do
    if [ ! "${MY_USER}" == "$( stat -c %U ${item} )" ]; then
        ## may take some time
        sudo chown ${MY_USER}:${MY_USER} -R ${item}
    fi
done

## source, to provide environment
cd ${YOCTO_DIR}
source oe-init-build-env $BUILD_DIR

## config files
cp -arf ${YOCTO_DIR}/meta-lothars-configs/conf/bblayers.conf.sample ${BUILD_DIR}/conf/bblayers.conf
cp -arf ${YOCTO_DIR}/meta-lothars-configs/conf/local.conf.sample ${BUILD_DIR}/conf/local.conf

## adjust config files
sed "s/  ~\/poky\//  \/home\/$(whoami)\/poky\//g" -i ${BUILD_DIR}/conf/bblayers.conf

## build
cd ${BUILD_DIR}
bitbake core-image-minimal || exit 1

echo "READY."
echo
