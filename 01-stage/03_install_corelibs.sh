#!/bin/sh

. utils/dirstack
. utils/err
. utils/exists
. utils/logger

if ! exists make; then
    err "Please install make"
    exit 1
fi

pushd sources

if ! [ -f "corelibs.installed" ]; then
    pushd corelibs
    echo ":: Installing corelibs into the rootfs"
    log corelibs.install.log make DESTDIR="$ROOTFS" install
    popd

    touch corelibs.installed
fi

echo ":: Corelibs installed in rootfs"

popd
