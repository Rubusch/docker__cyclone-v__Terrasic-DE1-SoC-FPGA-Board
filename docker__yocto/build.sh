#!/bin/bash -e
## resources:
## https://rocketboards.org/foswiki/Documentation/YoctoDoraBuildWithMetaAltera
export BUILDDIR=~/poky/build
chown $(whoami):$(whoami) -R $BUILDDIR

## config files
cp -arf /home/$(whoami)/poky/meta-lothars-configs/conf/bblayers.conf.sample ${BUILDDIR}/conf/bblayers.conf
cp -arf /home/$(whoami)/poky/meta-lothars-configs/conf/local.conf.sample ${BUILDDIR}/conf/local.conf

## source again, before start building
cd ~/poky
source oe-init-build-env $BUILDDIR

## build
bitbake core-image-minimal
