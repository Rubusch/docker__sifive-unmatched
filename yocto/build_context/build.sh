#!/bin/sh -ex
#
# references:
# https://github.com/sifive/meta-sifive
MY_USER="$(whoami)"
MY_HOME="/home/${MY_USER}"
YOCTO_DIR="${MY_HOME}/poky"
BUILD_DIR="${YOCTO_DIR}/build"

## permissions
for item in "${YOCTO_DIR}" "${BUILD_DIR}" "${MY_HOME}/.gitconfig" "${MY_HOME}/.ssh"; do
    test -e "${item}" || continue
    if [ ! "${MY_USER}" = "$( stat -c %U "${item}" )" ]; then
        ## may take some time
        sudo chown "${MY_USER}:${MY_USER}" -R "${item}"
    fi
done

## ssh known_hosts
touch ${SSH_KNOWN_HOSTS}
for item in "github.com" "bitbucket.org"; do
    if [ "" == "$( grep ${item} -r ${SSH_KNOWN_HOSTS} )" ]; then
        ssh-keyscan "${item}" >> "${SSH_KNOWN_HOSTS}"
    fi
done

## sources
cd "${YOCTO_DIR}"
if [ ! -d .repo ]; then
    repo init -u git://github.com/sifive/meta-sifive -b 2021.05 -m tools/manifests/sifive.xml
    repo sync
    repo start work --all
fi

## final installation
chmod a+x ./meta-sifive/setup.sh
./meta-sifive/setup.sh


## enter environment
. ./openembedded-core/oe-init-build-env

## parallelize build
## NB: check out meta-sifi and its readme for different images, settings, toolchain, etc.
export PARALLEL_MAKE="-j 4"
export BB_NUMBER_THREADS=4
export MACHINE="unmatched"

## build
bitbake demo-coreip-cli || exit 1

echo "READY."
echo
