#!/bin/bash -e
export DEFCONFIG=lothars__socrates_cyclone5_defconfig
export MY_HOME="$(pwd)"
export USER="$(whoami)"
export BUILDDIR="${MY_HOME}/buildroot"

sudo chown ${USER}:${USER} -R ${BUILDDIR}

cd ${MY_HOME}/buildroot
make ${DEFCONFIG}
make -j8

echo "READY."
echo
