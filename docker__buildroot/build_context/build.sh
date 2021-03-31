#!/bin/bash -e
DEFCONFIG=lothars__socrates_cyclone5_defconfig
MY_HOME="$(pwd)"
USER="$(whoami)"
BUILD_DIR="${MY_HOME}/buildroot"

for item in ${BUILD_DIR}; do
    sudo chown ${USER}:${USER} -R ${item}
done

cd ${MY_HOME}/buildroot
make ${DEFCONFIG}
make -j8

echo "READY."
echo
