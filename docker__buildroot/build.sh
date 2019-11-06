#!/bin/bash -e
##
## started with:
## $ docker run -ti -v $PWD/mnt:$(pwd)/output afb489d932bc
##
#export DEFCONFIG=raspberrypi3__lothar_defconfig
export DEFCONFIG=de1soc__lothar_defconfig

## avoid checks for being "root"
export FORCE_UNSAFE_CONFIGURE=1

cd buildroot
make ${DEFCONFIG}
make -j8

## obtain build artifacts
cp -arvf /root/buildroot/output/* /mnt/
