FROM ubuntu:19.10
MAINTAINER Lothar Rubusch <lotophagon@protonmail.com>
WORKDIR /root
ENV DEBIAN_FRONTEND=noninteractive

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
        locales

RUN apt-get install -y \
        bc \
        cpio \
        rsync


RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8


################################################################################
## get sources
RUN git clone -j4 --depth=1 --branch lothar/cyclone-v-devel https://github.com/Rubusch/buildroot.git buildroot
## alternatively get official buildrooot
#RUN git clone -j4 --depth=1 https://github.com/buildroot/buildroot.git buildroot


################################################################################
## command mode
COPY build.sh /usr/local/bin/build.sh
CMD ["/bin/bash", "/usr/local/bin/build.sh"]
