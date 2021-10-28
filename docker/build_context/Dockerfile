################################################################################
## the USER is needed to make it available as --build-arg
## in case docker complains for a not set USER, perhaps you forgot to
## use --build-arg USER=$USER
ARG USER="${USER}"
ARG UID="${UID}"
ARG GID="${GID}"

ARG DOCKER_BASE="sandbox"
ARG DOCKER_BASE_TAG="20211027"


################################################################################
FROM ${USER}/${DOCKER_BASE}:${DOCKER_BASE_TAG} AS sifive-unmatched
MAINTAINER Lothar Rubusch <l.rubusch@gmail.com>
ENV DEBIAN_FRONTEND=noninteractive


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
