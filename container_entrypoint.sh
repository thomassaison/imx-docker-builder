#! /bin/bash

source imx-yocto-bsp/sources/poky/oe-init-build-env build
export LC_ALL=en_US.UTF-8
bitbake core-image-minimal