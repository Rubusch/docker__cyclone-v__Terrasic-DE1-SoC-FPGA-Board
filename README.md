# Container for my Terrasic DE1-SoC FPGA Board (Altera Cyclone V)

Docker for Terrasic's Cyclone V SoC FPGA board: DE1-SoC

UNDER CONSTRUCTION



## Resources

yocto
https://rocketboards.org/foswiki/Documentation/YoctoDoraBuildWithMetaAltera




## Build

```
$ cd ./docker__buildroot/
$ time docker build --no-cache -t rubuschl/de1soc-buildroot:$(date +%Y%m%d%H%M%S) .
```

## Usage

```
$ docker images
    REPOSITORY                TAG                 IMAGE ID            CREATED             SIZE
    rubuschl/de1soc-buildroot 20191104161353      cbf4cb380168        24 minutes ago      10.5GB
    ubuntu                    xenial              5f2bf26e3524        4 days ago          123MB

$ time docker run -ti --rm -v $PWD/output:/mnt rubuschl/de1soc-buildroot:20191104161353
```


## Debug

```
$ docker run -ti rubuschl/de1soc-buildroot:20191104161353 /bin/bash
```


TODO set up with yocto and meta-altera layer
