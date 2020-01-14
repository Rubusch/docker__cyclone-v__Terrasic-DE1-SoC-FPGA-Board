#!/bin/bash -e
## resources:
## https://rocketboards.org/foswiki/Documentation/YoctoDoraBuildWithMetaAltera
export YOCTODIR="/home/$(whoami)/poky"
export BUILDDIR="${YOCTODIR}/build"
chown $(whoami):$(whoami) -R $BUILDDIR

## source again, before start building
cd ${YOCTODIR}
source oe-init-build-env $BUILDDIR

## config files
cp -arf ${YOCTODIR}/meta-lothars-configs/conf/bblayers.conf.sample ${BUILDDIR}/conf/bblayers.conf
cp -arf ${YOCTODIR}/meta-lothars-configs/conf/local.conf.sample ${BUILDDIR}/conf/local.conf

## adjust config files
sed "s/  ~\/poky\//  \/home\/$(whoami)\/poky\//g" -i ${BUILDDIR}/conf/bblayers.conf

## build
bitbake core-image-minimal
