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

if ! [ -f "tcc.installed" ]; then
    pushd tinycc
    echo ":: Installing TinyCC into the rootfs"
    log tcc.install.log make DESTDIR="$ROOTFS" install
    popd

    echo ":: Fixing libtcc1.a and runmain.o installation"
    pushd "$ROOTFS/lib/"
    if ! [ -f libtcc1.a ]; then
        ln tcc/libtcc1.a libtcc1.a
    fi
    if ! [ -f runmain.o ]; then
        ln tcc/runmain.o runmain.o
    fi
    popd

    touch tcc.installed
fi
echo ":: TinyCC installed in rootfs"

popd
