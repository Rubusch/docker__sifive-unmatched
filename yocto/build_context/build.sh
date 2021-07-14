#!/bin/sh -ex
#
# references:
# https://github.com/sifive/meta-sifive

MY_USER="$(whoami)"
MY_HOME="/home/${MY_USER}"
SSH_DIR="${MY_HOME}/.ssh"
SSH_KNOWN_HOSTS="${SSH_DIR}/known_hosts"
REPO_BRANCH="2021.05"
YOCTO_DIR="${MY_HOME}/poky"
BUILD_DIR="${YOCTO_DIR}/build"
YOCTO_ARGS="$@"

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
if [ ! -d "${YOCTO_DIR}/.repo" ]; then
    cd "${YOCTO_DIR}"
    repo init -u git://github.com/sifive/meta-sifive -b "${REPO_BRANCH}" -m tools/manifests/sifive.xml
    repo sync
    repo start work --all
fi

## final installation
cd "${YOCTO_DIR}"
chmod a+x ./meta-sifive/setup.sh
./meta-sifive/setup.sh

## enter environment
cd "${YOCTO_DIR}/openembedded-core"
. ./oe-init-build-env

## parallelize build
## NB: check out meta-sifi and its readme for different images, settings, toolchain, etc.
export PARALLEL_MAKE="-j 4"
export BB_NUMBER_THREADS=4
export MACHINE="unmatched"

## build
bitbake demo-coreip-cli "${YOCTO_ARGS}" || exit 1

echo "READY."
echo
