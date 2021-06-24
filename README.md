[![CircleCI](https://circleci.com/gh/Rubusch/docker__cyclone-v__de1-soc-fpga.svg?style=shield)](https://circleci.com/gh/Rubusch/docker__cyclone-v__de1-soc-fpga)
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)


# Container for my Terrasic DE1-SoC FPGA Board (Altera Cyclone V)

Docker for Terrasic's Cyclone V SoC FPGA board: DE1-SoC

![Cabeling](pics/setup.jpg)



## Resources

yocto (old)
https://rocketboards.org/foswiki/Documentation/YoctoDoraBuildWithMetaAltera

https://rocketboards.org/foswiki/view/Documentation/YoctoDoraBuildWithMetaAltera

https://rocketboards.org/foswiki/view/Documentation/AlteraSoCDevelopmentBoardYoctoGettingStarted

SoC FPGAs in general (community)
https://rocketboards.org/


SoC FPGA U-Boot
https://github.com/altera-opensource/u-boot-socfpga.git


## Tools Needed

```
$ sudo curl -L "https://github.com/docker/compose/releases/download/1.28.6/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
$ sudo chmod a+x /usr/local/bin/docker-compose
```

NB: Where 1.28.6 is the latest version (currently not supported by devian/ubuntu package management)  


## Buildroot

### Build

```
$ cd ./docker__buildroot/
$ docker-compose up
```


### USAGE

```
$ docker-compose -f ./docker-compose.yml run --rm de1soc_buildroot /bin/bash

$ build.sh
```


## Yocto

Using the kraj/meta-altera layer is the valid legacy setup. Nowadays the Linux mainline (5.2.x) and Das U-Boot (2019.x) have full support for the DE1-SoC Board's Cyclone V. Though the meta-altera does the setup for MACHINE "cyclone5".  

It is fine for ``bitbake meta-toolchain``, but won't build the image (no correct u-boot settings, thus no spl and yocto stops at bundling the wic image) - FIXME.  



### Build

```
$ cd ./docker__yocto/
$ docker-compose up
```

In case of a re-build, make sure to clean sufficiently before  

```
$ rm -rf ./output/tmp/ ./output/bitbake.lock ./output/bitbake.sock
```

```
$ docker-compose -f ./docker-compose.yml run --rm de1soc_yocto /bin/bash
```

**yocto SDK** - Inside the **same** session, you can compile as follows.  

```
docker$ ~/poky/build/tmp/deploy/sdk/poky-glibc-x86_64-meta-toolchain-cortexa9hf-neon-cyclone5-toolchain-2.7.2.sh
   > /opt/toolchain-poky-2.7.2
   > Y

docker$ . /opt/toolchain-poky-2.7.2/environment-setup-cortexa9hf-neon-poky-linux-gnueabi

docker$ ${CC} hello.c -o hello.exe
```

Alternatively use a Makefile and inside work with variable _CC_. A direct call to ``arm-gnueabi...-gcc`` will not work with yocto built toolchains. It is supposed to use common Make compile variables, such as _CC_ or Makefiles directly.  



### SD Card

UNDER CONSTRUCTION  

Fetch a separate clone of the u-boot-socfpga repo, and build it inside the docker container with the installed toolchain.  

```
$ cd output

$ git clone https://github.com/altera-opensource/u-boot-socfpga.git
```

Load container and install sdk toolchain, example tag **20191104161353**  


### Development

```
$ docker-compose -f ./docker-compose.yml run --rm de1soc_yocto /bin/bash


docker$ ~/poky/build/tmp/deploy/sdk/poky-glibc-x86_64-meta-toolchain-cortexa9hf-neon-cyclone5-toolchain-2.7.2.sh
   > /opt/toolchain-poky-2.7.2
   > Y

docker$ . /opt/toolchain-poky-2.7.2/environment-setup-cortexa9hf-neon-poky-linux-gnueabi
```

Change into u-boot-socfpga and build it, this will generate the correct spl and image files  

```
docker$ cd ~/poky/build/u-boot-socfpga

docker$ git branch --all

docker$ git checkout socfpga_v2019.04

docker$ make socfpga_cyclone5_defconfig

docker$ make -j8
```



### Clean

Thoroughly clean yocto by removing  
* ``./output/sstate-cache``
* ``./output/tmp``
* ``$ find ./output -name \*.sock -delete``
* remove local.conf and bblayers.conf



## Issues

* yocto: kernel fails to compile, dtb file missing  

```
Task (/home/user/poky/meta-altera/recipes-kernel/linux/linux-altera_5.2.bb:do_compile) failed with exit code '1'
```

FIX: configure in the local.conf which specific dts / dtb (board) is needed exactly, the fall back tries to build all available in the meta-altera. All dts configs available in the meta-altera are not available in the kernel sources, though.  

* yocto: the wks file declared for cyclone5 (wic, i.e. partition layout), refers a fit/spl file for u-boot, which is not built for cyclone5 automatically and still needs fixes for cyclone5  
