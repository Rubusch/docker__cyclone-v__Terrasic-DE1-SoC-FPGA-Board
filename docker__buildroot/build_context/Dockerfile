FROM ubuntu:20.04
MAINTAINER Lothar Rubusch <lotophagon@protonmail.com>
ENV DEBIAN_FRONTEND=noninteractive


################################################################################
## the USER is needed to make it available as --build-arg
## in case docker complains for a not set USER, perhaps you forgot to use --build-arg USER=$USER
ARG USER=""
ARG BRANCH_USER="lothar/cyclone-v-devel"


################################################################################
## package manager

## (opt) fix for sporadic problems like: "Not Found [IP: 91.189.88.152 80]"
#RUN sed -i'' 's/archive.ubuntu.com/us.archive.ubuntu.com/' /etc/apt/sources.list
RUN sed -i'' 's/archive.ubuntu.com/ubuntu.ethz.ch/' /etc/apt/sources.list

## set up apt fully functional
RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y --purge
RUN apt-get install -y  \
        apt-utils

RUN apt-get install -y  \
        libncurses5-dev \
        zlib1g-dev \
        gawk \
        wget \
        git-core \
        make \
        gcc \
        g++ \
        build-essential \
        bison \
        flex \
        binutils \
        unzip \
        python \
        bzip2 \
        libssl-dev \
        locales \
        bc \
        cpio \
        rsync \
        sudo


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
RUN chown $USER:$USER -R /home/$USER


################################################################################
## get (my) sources
USER $USER

WORKDIR /home/$USER
RUN git clone -j4 --depth=1 --branch ${BRANCH_USER} https://github.com/Rubusch/buildroot.git buildroot
## alternatively get official buildrooot
#RUN git clone -j4 --depth=1 https://github.com/buildroot/buildroot.git buildroot


################################################################################
## command mode
COPY build.sh /usr/local/bin/build.sh
CMD ["/bin/bash", "/usr/local/bin/build.sh"]
