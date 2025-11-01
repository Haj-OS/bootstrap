#!/bin/sh

. utils/dirstack
. utils/err
. utils/exists
. utils/logger

pushd sources

if ! [ -f "compilers.setup" ]; then
    pushd $ROOTFS/bin
    cp -rf $SRCDIR/scripts/* .
    popd
    touch compilers.setup
fi

popd
