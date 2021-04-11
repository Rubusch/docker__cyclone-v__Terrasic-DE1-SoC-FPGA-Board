#!/bin/bash -e
DEFCONFIG=lothars__socrates_cyclone5_defconfig
MY_HOME="$(pwd)"
USER="$(whoami)"
BUILD_DIR="${MY_HOME}/buildroot"
DL_DIR="${BUILD_DIR}/dl"
OUTPUT_DIR="${BUILD_DIR}/output"

for item in ${BUILD_DIR} ${DL_DIR} ${OUTPUT_DIR}; do
    if [ "${USER}" != "$(stat -c %U ${item} )" ]; then
        sudo chown ${USER}:${USER} -R ${item}
    fi
done

cd ${MY_HOME}/buildroot
make ${DEFCONFIG}
make -j8

echo "READY."
echo
