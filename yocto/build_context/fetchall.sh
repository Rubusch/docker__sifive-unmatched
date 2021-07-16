#!/bin/sh -e
#
# references:
# https://github.com/sifive/freedom-u-sdk

MY_USER="$(whoami)"
MY_HOME="/home/${MY_USER}"
SSH_DIR="${MY_HOME}/.ssh"
SSH_KNOWN_HOSTS="${SSH_DIR}/known_hosts"
REPO_BRANCH="2021.06"
YOCTO_DIR="${MY_HOME}/poky"
YOCTO_IMAGE="demo-coreip-cli"
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
touch "${SSH_KNOWN_HOSTS}"
for item in "github.com" "bitbucket.org"; do
    if [ "" = "$( grep "${item}" -r "${SSH_KNOWN_HOSTS}" )" ]; then
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
cd "${YOCTO_DIR}"
. ./openembedded-core/oe-init-build-env

## parallelize build
## NB: check out meta-sifi and its readme for different images, settings, toolchain, etc.
export PARALLEL_MAKE="-j $(nproc)"
export BB_NUMBER_THREADS="$(nproc)"

## build
MACHINE=unmatched bitbake "${YOCTO_IMAGE}" --runall=fetch || exit 1

## banner stuff
echo
echo "update manually (performed by this script):"
echo "$ cd ${YOCTO_DIR}"
echo "$ chmod a+x ./meta-sifive/setup.sh"
echo "$ ./meta-sifive/setup.sh"
echo

echo "prepare a manual build, or run build.sh"
echo "$ cd ${YOCTO_DIR}/openembedded-core && . ./oe-init-build-env build"
echo "$ bitbake ${YOCTO_IMAGE}"
echo

echo "READY."
echo
