#!/bin/sh -e
#
# references:
# https://github.com/sifive/freedom-u-sdk

MY_USER="$(whoami)"
MY_HOME="/home/${MY_USER}"
REPO_BRANCH="2021.06"
YOCTO_DIR="${MY_HOME}/poky"
YOCTO_IMAGE="demo-coreip-cli"
BUILD_DIR="${YOCTO_DIR}/build"

00_devenv.sh "${YOCTO_DIR}" "${BUILD_DIR}"

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
echo "$ cd ${YOCTO_DIR}"
echo "$ . ./openembedded-core/oe-init-build-env build"
echo "$ bitbake ${YOCTO_IMAGE}"
echo

echo "READY."
echo
