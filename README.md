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

$ time docker run -ti --user=$USER:$USER --workdir=/home/$USER -v $PWD/output:/home/$USER/output rubuschl/de1soc-buildroot:20191104161353
```


### Debug

```
$ docker run -ti --user=$USER:$USER --workdir=/home/$USER -v $PWD/output:/home/$USER/output rubuschl/de1soc-buildroot:20191104161353 /bin/bash
```


## Yocto

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

$ time docker run -ti --user=$USER:$USER --workdir=/home/$USER -v $PWD/output:/home/$USER/output rubuschl/de1soc-yocto:20191104161353
```


### Debug

```
$ docker run -ti --user=$USER:$USER --workdir=/home/$USER -v $PWD/output:/home/$USER/output rubuschl/de1soc-yocto:20191104161353 /bin/bash
```

