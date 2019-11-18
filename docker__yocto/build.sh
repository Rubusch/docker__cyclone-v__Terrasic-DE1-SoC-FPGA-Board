#!/bin/bash -e
## resources:
## https://rocketboards.org/foswiki/Documentation/YoctoDoraBuildWithMetaAltera
export BUILDDIR=~/poky/build
chown $(whoami):$(whoami) -R $BUILDDIR

## is this a rebuild? if not, init the confis
if [[ ! -f $BUILDDIR/conf/bblayers.conf ]]; then
    cd ~/poky
    source oe-init-build-env $BUILDDIR

    ## adjust bblayers.conf
    sed -i '/  "/s/.*/  \/home\/user\/poky\/meta-altera \\/g' $BUILDDIR/conf/bblayers.conf
    ## using meta-openembedded - why?
    #sed -i '/  "/s/.*/  \/home\/user\/poky\/meta-openembedded \\/g' $BUILDDIR/conf/bblayers.conf
    #echo '  /home/user/poky/meta-altera \' >> $BUILDDIR/conf/bblayers.conf
    echo '  "' >> $BUILDDIR/conf/bblayers.conf
fi

if [[ ! -f $BUILDDIR/conf/local.conf ]]; then
    ## adjustments to local.conf

    ## MACHINE
    sed -i '/MACHINE ??= "qemux86"/s/.*/MACHINE ?= "cyclone5"/g' $BUILDDIR/conf/local.conf

    ## kernel
#    echo 'PREFERRED_PROVIDER_virtual/kernel = "linux-altera"' >> $BUILDDIR/conf/local.conf
    echo 'PREFERRED_PROVIDER_virtual/kernel = "linux-altera-ltsi"' >> $BUILDDIR/conf/local.conf
    echo 'PREFERRED_VERSION_linux-altera = "4.17%"' >> $BUILDDIR/conf/local.conf

    ## toolchain
    ## alternatively (former old toolchain): ANGSTROM_GCC_VERSION_arm = "linaro-4.9%"
    echo 'GCCVERSION = "linaro-5.2"' >> $BUILDDIR/conf/local.conf
    echo 'SDKGCCVERSION = "linaro-5.2"' >> $BUILDDIR/conf/local.conf
    echo 'DEFAULTTUNE = "cortexa9hf-neon"' >> $BUILDDIR/conf/local.conf

    echo 'EXTRA_USERS_PARAMS = "usermod -P root root; "' >> $BUILDDIR/conf/local.conf

    ## uboot setup
    echo 'UBOOT_CONFIG = "cyclone5-socrates"' >> $BUILDDIR/conf/local.conf
    echo 'KERNEL_DEVICETREE = "socfpga_cyclone5_socrates.dtb"' >> $BUILDDIR/conf/local.conf
    echo 'UBOOT_EXTLINUX_FDT_default ?= "../socfpga_cyclone5_socrates.dtb"' >> $BUILDDIR/conf/local.conf

fi

## source again, before start building
cd ~/poky
source oe-init-build-env $BUILDDIR


## build
bitbake core-image-minimal
