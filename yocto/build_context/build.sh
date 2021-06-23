#!/bin/bash -e
#
# references:
# https://github.com/sifive/meta-sifive

export USER="$(whoami)"
export YOCTO_BRANCH="dunfell"
export MY_HOME="/home/${USER}"
export YOCTO_DIR="${MY_HOME}/poky"
export BUILDDIR="${YOCTO_DIR}/build"


## this may take time
# TODO check with stat   
sudo chown ${USER}:${USER} -R ${YOCTO_DIR}


cd ${YOCTO_DIR}

## sifive: fetch meta layers
if [[ ! -d .repo ]]; then
    repo init -u git://github.com/sifive/meta-sifive -b 2021.05 -m tools/manifests/sifive.xml
    repo sync
    repo start work --all
fi

## final installation
chmod a+x ./meta-sifive/setup.sh
./meta-sifive/setup.sh


## enter environment
source ./openembedded-core/oe-init-build-env

## parallelize build
export PARALLEL_MAKE="-j 4"
export BB_NUMBER_THREADS=4
export MACHINE="freedom-u540"

## build
bitbake demo-coreip-cli

echo "READY."
echo
