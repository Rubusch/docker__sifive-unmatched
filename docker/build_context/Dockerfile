################################################################################
## ATTENTION: multistage build
##
## based on current USER and TAG, DOCKER_BASE:
## https://github.com/Rubusch/docker__zephyr-base
##
################################################################################
## base image settings
ARG USER="${USER}"
ARG DOCKER_BASE="sandbox"
ARG DOCKER_BASE_TAG="20211028"


################################################################################
## base image
FROM ${USER}/${DOCKER_BASE}:${DOCKER_BASE_TAG} AS sifive-unmatched
MAINTAINER Lothar Rubusch <l.rubusch@gmail.com>
ENV DEBIAN_FRONTEND=noninteractive


################################################################################
## environment (applied ARG/ENV must come after FROM declaration)
ARG USER="${USER}"


################################################################################
## apt
RUN sudo apt-get install -y  \
    git-core \
    dosfstools \
    minicom \
    python


################################################################################
## tools
USER $USER
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo
RUN chmod a+x /usr/local/bin/repo


################################################################################
## get sources
USER $USER
WORKDIR /home/$USER
RUN mkdir -p /home/$USER/poky


################################################################################
## command mode
USER ${USER}
WORKDIR /home/$USER
COPY *.sh /usr/local/bin/
CMD ["/bin/bash", "/usr/local/bin/10_sifive-prepare.sh"]
