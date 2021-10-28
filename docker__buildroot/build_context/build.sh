#!/bin/sh -e
MY_USER="$(whoami)"
MY_HOME="$(pwd)"
BUILDROOT_DIR="${MY_HOME}/buildroot"
BRANCH_USER="lothar/cyclone-v-devel"
DEFCONFIG=lothars__socrates_cyclone5_defconfig

00_devenv.sh "${BUILDROOT_DIR}"

## initial clone
FIRST="$(ls -A "${BUILDROOT_DIR}")" || true
if [ -z "${FIRST}" ]; then
    git clone -j4 --depth=1 --branch "${BRANCH_USER}" https://github.com/Rubusch/buildroot.git buildroot
    ## alternatively get official buildrooot
    #RUN git clone -j4 --depth=1 https://github.com/buildroot/buildroot.git buildroot
fi

cd "${BUILDROOT_DIR}"
make "${DEFCONFIG}"
make -j8

echo "READY."
echo
