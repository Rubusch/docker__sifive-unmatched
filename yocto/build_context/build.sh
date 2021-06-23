#!/bin/bash -e
#
# references:
# https://github.com/sifive/meta-sifive

export MY_USER="$(whoami)"
export YOCTO_BRANCH="dunfell"
export MY_HOME="/home/${MY_USER}"
export YOCTO_DIR="${MY_HOME}/poky-${YOCTO_BRANCH}"
export BUILD_DIR="${YOCTO_DIR}/build"


## this may take time
for item in ${BUILD_DIR} ${YOCTO_DIR}; do
    if [ ! "${MY_USER}" == "$( stat -c %U ${item} )" ]; then
        ## may take some time
        sudo chown ${MY_USER}:${MY_USER} -R ${item}
    fi
done

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
## NB: check out meta-sifi and its readme for different images, settings, toolchain, etc.
export PARALLEL_MAKE="-j 4"
export BB_NUMBER_THREADS=4
export MACHINE="freedom-u740"

## build
bitbake demo-coreip-cli || exit 1

echo "READY."
echo
