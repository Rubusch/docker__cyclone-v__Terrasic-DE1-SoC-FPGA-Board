################################################################################
ARG USER="${USER}"
ARG DOCKER_BASE="sandbox"
ARG DOCKER_BASE_TAG="20211028"


################################################################################
FROM ${USER}/${DOCKER_BASE}:${DOCKER_BASE_TAG} AS de1soc_buildroot
MAINTAINER Lothar Rubusch <l.rubusch@gmail.com>
ENV DEBIAN_FRONTEND=noninteractive


################################################################################
## get (my) sources
USER $USER
WORKDIR /home/$USER


################################################################################
## command mode
USER $USER
WORKDIR /home/$USER
COPY *.sh /usr/local/bin/
CMD ["/bin/bash", "/usr/local/bin/build.sh"]
