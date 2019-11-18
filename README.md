# Container for my Terrasic DE1-SoC FPGA Board (Altera Cyclone V)

Docker for Terrasic's Cyclone V SoC FPGA board: DE1-SoC


## Resources

yocto  

https://rocketboards.org/foswiki/Documentation/YoctoDoraBuildWithMetaAltera

https://rocketboards.org/foswiki/view/Documentation/YoctoDoraBuildWithMetaAltera

https://rocketboards.org/foswiki/view/Documentation/AlteraSoCDevelopmentBoardYoctoGettingStarted


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

CURRENTLY BROKEN - ```Task (/home/user/poky/meta-altera/recipes-kernel/linux/linux-altera_5.2.bb:do_compile) failed with exit code '1'```

Using the kraj/meta-altera layer.


### Build

```
$ cd ./docker__yocto/
$ time docker build --build-arg USER=$USER -t rubuschl/de1soc-yocto:$(date +%Y%m%d%H%M%S) .
```


### Usage

```
$ docker images
    REPOSITORY                TAG                 IMAGE ID            CREATED             SIZE
    rubuschl/de1soc-yocto 20191104161353      cbf4cb380168        24 minutes ago      10.5GB
    ubuntu                    xenial              5f2bf26e3524        4 days ago          123MB

$ time docker run -ti -v $PWD/output:/home/$USER/poky/build --user=$USER:$USER --workdir=/home/$USER rubuschl/de1soc-yocto:20191104161353
```

Append ``/bin/bash`` to the above for having a debug shell into the container instance.

Thoroughly clean yocto by removing
* ``./output/sstate-cache``
* ``./output/tmp``

