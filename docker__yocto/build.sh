#!/bin/bash -e
## resources:
## https://rocketboards.org/foswiki/Documentation/YoctoDoraBuildWithMetaAltera
export BUILDDIR=~/poky/build
chown $(whoami):$(whoami) -R $BUILDDIR

## is this a rebuild? if not, init the confis
if [[ ! -f $BUILDDIR/conf/local.conf ]]; then
    cd ~/poky
    source oe-init-build-env $BUILDDIR

    ## adjust bblayers.conf
    sed -i '/  "/s/.*/  \/home\/user\/poky\/meta-altera \\/g' $BUILDDIR/conf/bblayers.conf
    ## using meta-openembedded - why?
    #sed -i '/  "/s/.*/  \/home\/user\/poky\/meta-openembedded \\/g' $BUILDDIR/conf/bblayers.conf
    #echo '  /home/user/poky/meta-altera \' >> $BUILDDIR/conf/bblayers.conf
    echo '  "' >> $BUILDDIR/conf/bblayers.conf


    ## adjust local.conf
    sed -i '/MACHINE ??= "qemux86"/s/.*/MACHINE ?= "cyclone5"/g' $BUILDDIR/conf/local.conf

    echo 'PREFERRED_PROVIDER_virtual/kernel = "linux-altera"' >> $BUILDDIR/conf/local.conf
    echo 'PREFERRED_VERSION_linux-altera = "4.17%"' >> $BUILDDIR/conf/local.conf

    echo 'EXTRA_USERS_PARAMS = "usermod -P root root; "' >> $BUILDDIR/conf/local.conf
fi

## source again, before start building
cd ~/poky
source oe-init-build-env $BUILDDIR


## build
bitbake core-image-minimal
