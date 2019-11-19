# Container for my Terrasic DE1-SoC FPGA Board (Altera Cyclone V)

Docker for Terrasic's Cyclone V SoC FPGA board: DE1-SoC

![Cabeling](pics/setup.jpg)



## Resources

yocto
https://rocketboards.org/foswiki/Documentation/YoctoDoraBuildWithMetaAltera

https://rocketboards.org/foswiki/view/Documentation/YoctoDoraBuildWithMetaAltera

https://rocketboards.org/foswiki/view/Documentation/AlteraSoCDevelopmentBoardYoctoGettingStarted

SoC FPGAs in general (community)
https://rocketboards.org/



## Buildroot

### Build

```
$ cd ./docker__buildroot/
$ time docker build --build-arg USER=$USER -t rubuschl/de1soc-buildroot:$(date +%Y%m%d%H%M%S) .
```


### Usage

```
$ docker images
    REPOSITORY                TAG                 IMAGE ID            CREATED             SIZE
    rubuschl/de1soc-buildroot 20191104161353      cbf4cb380168        24 minutes ago      10.5GB
    ubuntu                    xenial              5f2bf26e3524        4 days ago          123MB

$ time docker run --rm -ti --user=$USER:$USER --workdir=/home/$USER -v $PWD/dl:/home/$USER/buildroot/dl -v $PWD/output:/home/$USER/buildroot/output rubuschl/de1soc-buildroot:20191104161353
```

Append ``/bin/bash`` to the above for having a shell into a container instance.



## Yocto



Using the kraj/meta-altera layer.


### Build

```
$ cd ./docker__yocto/
$ time docker build --no-cache --build-arg USER=$USER -t rubuschl/de1soc-yocto:$(date +%Y%m%d%H%M%S) .
```


### Usage

```
$ docker images
    REPOSITORY                TAG                 IMAGE ID            CREATED             SIZE
    rubuschl/de1soc-yocto 20191104161353      cbf4cb380168        24 minutes ago      10.5GB
    ubuntu                    xenial              5f2bf26e3524        4 days ago          123MB

$ time docker run -ti -v $PWD/output:/home/$USER/poky/build --user=$USER:$USER --workdir=/home/$USER rubuschl/de1soc-yocto:20191104161353
```


### Build SDK

Append ``/bin/bash`` to the above for having a debug shell into the container instance.

```
$ docker images
    REPOSITORY                TAG                 IMAGE ID            CREATED             SIZE
    rubuschl/de1soc-yocto 20191104161353      cbf4cb380168        24 minutes ago      10.5GB
    ubuntu                    xenial              5f2bf26e3524        4 days ago          123MB

$ docker run -ti -v $PWD/output:/home/$USER/poky/build --user=$USER:$USER --workdir=/home/$USER rubuschl/de1soc-yocto:20191104161353 /bin/bash

docker$ sudo /usr/local/bin/build.sh
   (...)
   ## replace bitbake command with the following
   bitbake meta-toolchain

docker$ build.sh
   (zzzZZZzz...)

docker$ ./tmp/deploy/sdk/poky-glibc-x86_64-meta-toolchain-cortexa9hf-neon-vfpv4-toolchain-2.7.2.sh
   e.g. to /opt/toolchain-poky-2.7.2
```

Inside the **same** session, you can compile as follows.

```
docker$  . /opt/toolchain/toolchain-poky-2.7.2/environment-setup-cortexa9hf-neon-vfpv4-poky-linux-gnueabi

docker$ ${CC} hello.c -o hello.exe
```

Alternatively use a Makefile and inside work with variable _CC_. A direct call to ``arm-gnueabi...-gcc`` will not work with yocto built toolchains. It is supposed to use common Make compile variables, such as _CC_ or Makefiles directly.



### SD Card

TODO



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


* yocto: wic / wks settings are not working with cyclone5, try to turn the additional 'wic' stuff off in meta-altera
