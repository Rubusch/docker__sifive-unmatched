FROM ubuntu:20.04
MAINTAINER Lothar Rubusch <lotophagon@protonmail.com>
ENV DEBIAN_FRONTEND=noninteractive


################################################################################
## package manager

## the USER is needed to make it available as --build-arg
## in case docker complains for a not set USER, perhaps you forgot to use --build-arg USER=$USER
ARG USER="${USER}"

## the yocto branch
#ARG BRANCH_YOCTO="dunfell"
#
#ARG YOCTO_DIR="/home/$USER/poky-${BRANCH_YOCTO}"


################################################################################
## set up apt fully functional

## (opt) fix for sporadic problems like: "Not Found [IP: 91.189.88.152 80]"
#RUN sed -i'' 's/archive.ubuntu.com/us.archive.ubuntu.com/' /etc/apt/sources.list
RUN sed -i'' 's/archive.ubuntu.com/ubuntu.ethz.ch/' /etc/apt/sources.list

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
    dosfstools \
    vim \
    screen \
    minicom \
    sudo \
    curl \
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


################################################################################
## get tools

RUN mkdir -p /usr/local/bin
RUN chown $USER:$USER -R /usr/local

USER $USER
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo
RUN chmod a+x /usr/local/bin/repo


################################################################################
## get sources
WORKDIR /home/$USER
USER $USER

## prepare paths
RUN mkdir -p /home/$USER/configs
RUN mkdir -p /home/$USER/poky

## reset permissions
RUN chown $USER:$USER -R /home/$USER/

## bash config
RUN rm -f /home/$USER/.bashrc && ln -s /home/$USER/configs/.bashrc /home/$USER/

## vim config
RUN rm -f /home/$USER/.vimrc && ln -s /home/$USER/configs/.vimrc /home/$USER/

## emacs config
RUN rm -f /home/$USER/.emacs && ln -s /home/$USER/configs/.emacs /home/$USER/


################################################################################
## command mode
COPY build.sh /usr/local/bin/build.sh
COPY fetchall.sh /usr/local/bin/fetchall.sh
CMD ["/bin/bash", "/usr/local/bin/fetchall.sh"]
