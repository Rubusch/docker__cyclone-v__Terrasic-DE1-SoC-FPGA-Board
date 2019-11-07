#!/bin/bash -e

## avoid checks for being "root"
export FORCE_UNSAFE_CONFIGURE=1
export DEFCONFIG=lothars__socrates_cyclone5_defconfig

cd buildroot
make ${DEFCONFIG}
make -j8

## obtain build artifacts
cp -arvf /root/buildroot/output/* /mnt/
