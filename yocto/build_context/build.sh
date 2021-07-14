#!/bin/sh -ex
#
# references:
# https://github.com/sifive/freedom-u-sdk

MY_USER="$(whoami)"
MY_HOME="/home/${MY_USER}"
YOCTO_DIR="${MY_HOME}/poky"
BUILD_DIR="${YOCTO_DIR}/build"

## verify fetchall
fetchall.sh

## prepare
cd "${YOCTO_DIR}/openembedded-core"
. ./oe-init-build-env build

## parallelize build
## NB: check out meta-sifi and its readme for different images, settings, toolchain, etc.
export PARALLEL_MAKE="-j 4"
export BB_NUMBER_THREADS=4
export MACHINE="unmatched"

## build
bitbake demo-coreip-cli || exit 1

echo "READY."
echo
