FROM ubuntu:20.04
MAINTAINER Lothar Rubusch <lotophagon@protonmail.com>
WORKDIR /root
ENV DEBIAN_FRONTEND=noninteractive


################################################################################
## the USER is needed to make it available as --build-arg
## in case docker complains for a not set USER, perhaps you forgot to use --build-arg USER=$USER
ARG USER=""


################################################################################
## set up apt fully functional

## (opt) fix for sporadic problems like: "Not Found [IP: 91.189.88.152 80]"
#RUN sed -i'' 's/archive.ubuntu.com/us.archive.ubuntu.com/' /etc/apt/sources.list
RUN sed -i'' 's/archive.ubuntu.com/ubuntu.ethz.ch/' /etc/apt/sources.list

## set up apt fully functional
RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y --purge
RUN apt-get install -y  \
        apt-utils

RUN apt-get install -y  \
    build-essential \
    chrpath \
    diffstat \
    gawk \
    libncurses5-dev \
    texinfo \
    zlib1g-dev \
    bison \
    flex \
    binutils \
    unzip \
    python \
    bzip2 \
    libssl-dev \
    locales \
    libsdl1.2-dev \
    xterm \
    bc \
    cpio \
    rsync \
    wget \
    git-core \
    vim \
    screen \
    minicom \
    sudo \
    x11-apps


################################################################################
## locale settings
RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8


################################################################################
## setup user and run stuff under user
RUN useradd "$USER" -m --password "$USER"
RUN usermod -a -G sudo "$USER"
RUN sed -i '/%sudo/s/.*/%sudo   ALL=NOPASSWD: ALL/' /etc/sudoers
## reset permissions
RUN chown $USER:$USER -R /home/$USER


################################################################################
## get sources
USER $USER

WORKDIR /home/$USER
RUN mkdir -p /home/$USER/poky
RUN mkdir -p /home/$USER/meta-lothars-configs


################################################################################
## command mode
COPY build.sh /usr/local/bin/build.sh
CMD ["/bin/bash", "/usr/local/bin/build.sh"]
