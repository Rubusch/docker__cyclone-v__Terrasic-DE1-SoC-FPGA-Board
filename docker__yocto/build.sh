#!/bin/bash -e
## resources:
## https://rocketboards.org/foswiki/Documentation/YoctoDoraBuildWithMetaAltera
export BUILDDIR=~/poky/build
chown $(whoami):$(whoami) -R $BUILDDIR

cd ~/poky
source oe-init-build-env $BUILDDIR

####### UNDER CONSTRUCTION     
# cp -af ~/poky/meta-rpi/conf/local.conf.sample $BUILDDIR/conf/local.conf
# cp -af ~/poky/meta-rpi/conf/bblayers.conf.sample $BUILDDIR/conf/bblayers.conf

# ## WARNING: Do not include meta-yocto-bsp in your bblayers.conf.
# ## The Yocto BSP requirements for the Raspberry Pi are in meta-raspberrypi

# ## adjust bblayers.conf
# sed -i 's/poky-warrior/poky/g' $BUILDDIR/conf/bblayers.conf
# sed -i 's/\/rpi\//\/poky\//g' $BUILDDIR/conf/bblayers.conf

# ## adjust local.conf
# ##
# ## MACHINEs
# ##  raspberrypi (BCM2835)
# ##  raspberrypi0 (BCM2835)
# ##  raspberrypi0-wifi (BCM2835)
# ##  raspberrypi2 (BCM2836 or BCM2837 v1.2+)
# ##  raspberrypi3 (BCM2837)
# ##  raspberrypi-cm (BCM2835)
# ##  raspberrypi-cm3 (BCM2837)
# ##
# ## tunings:
# ##  arm1176jzfshf - for the the BCM2835 boards
# ##  cortexa7thf-neon-vfpv4 - for the BCM2836 and BCM2837 boards

# sed -i '/^MACHINE = "/s/.*/MACHINE = "raspberrypi3"/g' $BUILDDIR/conf/local.conf

# ## password off - off
# sed -i '/^EXTRA_IMAGE_FEATURES = "debug-tweaks"/s/.*/#EXTRA_IMAGE_FEATURES = "debug-tweaks"/g' $BUILDDIR/conf/local.conf

# ## password (reset to 'root')
# #sed -i '/INHERIT += "extrausers"/s/.*/#INHERIT += "extrausers"/g' $BUILDDIR/conf/local.conf
# sed -i '/^EXTRA_USERS_PARAMS = "usermod -P jumpnowtek root; "/s/.*/EXTRA_USERS_PARAMS = "usermod -P root root; "/g' $BUILDDIR/conf/local.conf

# ## passowrd: ask for resetting - off
# sed -i '/^INHERIT += "chageusers"/s/.*/#INHERIT += "chageusers"/g' $BUILDDIR/conf/local.conf
# sed -i '/^CHAGE_USERS_PARAMS = "chage -d0 root; "/s/.*/#CHAGE_USERS_PARAMS = "chage -d0 root; "/g' $BUILDDIR/conf/local.conf

# ## source again, before start building
# cd ~/poky
# source oe-init-build-env $BUILDDIR

# ## build
# bitbake console-image
