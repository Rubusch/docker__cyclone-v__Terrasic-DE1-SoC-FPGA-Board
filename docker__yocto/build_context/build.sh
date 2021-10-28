#!/bin/sh -e
## resources:
## https://rocketboards.org/foswiki/Documentation/YoctoDoraBuildWithMetaAltera

MY_USER="$(whoami)"
test -d "${MY_HOME}" || export MY_HOME="$(pwd)"
YOCTO_BRANCH="dunfell"
YOCTO_DIR="${MY_HOME}/poky"
BUILD_DIR="${YOCTO_DIR}/build"

## e.g.
## '-n' for a dryrun
## '--runall=fetch' for only download
## '-k --runall=fetch' for only download, don't stop on errors
export BB_FLAGS=${1}

00_devenv.sh "${YOCTO_DIR}" "${MY_HOME}/meta-lothars-configs"

## initial clone
if [ "1" = "$(find ${YOCTO_DIR} | wc -l)" ]; then
    cd ${MY_HOME}
    git clone -b "${YOCTO_BRANCH}" git://git.yoctoproject.org/poky "${YOCTO_DIR}"

    cd "${YOCTO_DIR}"
    git clone -b "${YOCTO_BRANCH}" git://git.openembedded.org/meta-openembedded
    git clone -b "${YOCTO_BRANCH}" https://github.com/meta-qt5/meta-qt5.git

    ## development: adjustable meta-layer
    git clone -b "lothar/${YOCTO_BRANCH}" https://github.com/Rubusch/meta-altera.git
    ## or (better) stay with the original
    #git clone -b master https://github.com/kraj/meta-altera.git
fi

## our meta-... layer
if [ ! -L "${YOCTO_DIR}/meta-lothars-configs" ]; then
    ln -s ${MY_HOME}/meta-lothars-configs ${YOCTO_DIR}/meta-lothars-configs
    sed "s/~/\/home\/$USER/g" -i ${YOCTO_DIR}/meta-lothars-configs/conf/bblayers.conf.sample
fi

## source, to provide environment
cd "${YOCTO_DIR}"
source oe-init-build-env "${BUILD_DIR}"

## config files
cp -arf "${YOCTO_DIR}/meta-lothars-configs/conf/bblayers.conf.sample" "${BUILD_DIR}/conf/bblayers.conf"
cp -arf "${YOCTO_DIR}/meta-lothars-configs/conf/local.conf.sample" "${BUILD_DIR}/conf/local.conf"
sed "s/  \/home\/user\/poky\//  \/home\/$(whoami)\/poky\//g" -i ${BUILD_DIR}/conf/bblayers.conf

## build
cd "${BUILD_DIR}"
bitbake "${BB_FLAGS}" core-image-minimal || exit 1

echo "READY."
echo
