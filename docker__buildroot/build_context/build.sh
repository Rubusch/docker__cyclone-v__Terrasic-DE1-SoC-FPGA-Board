#!/bin/bash -e
DEFCONFIG=lothars__socrates_cyclone5_defconfig
MY_HOME="$(pwd)"
USER="$(whoami)"
BUILD_DIR="${MY_HOME}/buildroot"

for item in ${BUILD_DIR}; do
    if [ "${USER}" != "$(stat -c %U ${item} )" ]; then
        sudo chown ${USER}:${USER} -R ${item}
    fi
done

cd ${MY_HOME}/buildroot
make ${DEFCONFIG}
make -j8

echo "READY."
echo
