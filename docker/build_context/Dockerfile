################################################################################
## the USER is needed to make it available as --build-arg
## in case docker complains for a not set USER, perhaps you forgot to
## use --build-arg USER=$USER
ARG USER="${USER}"
ARG UID="${UID}"
ARG GID="${GID}"

ENV DOCKER_BASE="sandbox"
ENV DOCKER_BASE_TAG="20211026"


################################################################################
FROM ${USER}/${DOCKER_BASE}:${DOCKER_BASE_TAG} AS sifive-unmatched
MAINTAINER Lothar Rubusch <l.rubusch@gmail.com>
ENV DEBIAN_FRONTEND=noninteractive


################################################################################
## set up apt fully functional

RUN apt-get install -y  \
    git-core \
    dosfstools \
    minicom \
    python


################################################################################
## get tools

USER $USER
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo
RUN chmod a+x /usr/local/bin/repo


################################################################################
## get sources
WORKDIR /home/$USER
USER $USER

## prepare paths
RUN mkdir -p /home/$USER/poky


################################################################################
## command mode
USER ${USER}
WORKDIR /home/$USER
COPY *.sh /usr/local/bin/
CMD ["/bin/bash", "/usr/local/bin/10_sifive-prepare.sh"]
