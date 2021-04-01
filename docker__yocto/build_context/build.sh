#!/bin/bash -e
## resources:
## https://rocketboards.org/foswiki/Documentation/YoctoDoraBuildWithMetaAltera

export MY_HOME="$(pwd)"
export USER="$(whoami)"
export YOCTODIR="${MY_HOME}/poky"
export BUILDDIR="${YOCTODIR}/build"

sudo chown ${USER}:${USER} -R ${BUILDDIR}

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

echo "READY."
echo
