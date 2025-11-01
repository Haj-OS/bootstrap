#!/bin/sh

. utils/dirstack
. utils/err
. utils/exists

if ! exists git; then
    err "Please install git"
    exit 1
fi

pushd sources

if ! [ -d protolibc ]; then
    echo ":: Downloading corelibs"
    git clone --depth=1 https://github.com/Haj-OS/corelibs.git

    echo ":: Patching Makefile"
    pushd corelibs 
    sed -i 's|PREFIX = /usr/local|PREFIX = /usr|' Makefile
    popd
fi

echo ":: corelibs downloaded"

popd
