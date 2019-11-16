#!/bin/bash -e
export DEFCONFIG=lothars__socrates_cyclone5_defconfig
cd ~/buildroot
make ${DEFCONFIG}
make -j8
