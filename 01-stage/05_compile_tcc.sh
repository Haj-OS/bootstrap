#!/bin/sh

. utils/dirstack
. utils/err
. utils/exists
. utils/logger

if ! exists make; then
    err "Please install make"
    exit 1
fi

if ! exists patch; then
    err "Please install patch"
    exit 1
fi

pushd sources

if ! [ -f "tcc.compiled" ]; then
    pushd tinycc
    echo ":: Patching TinyCC"
    log_both tcc.patch.log patch -p1 < ../../patches/tinycc_hajos.diff
    echo ":: Configuring TinyCC"
    log tcc.configure.log ./configure $TCC_CFG
    echo ":: Compiling TinyCC"
    log_both tcc.compilation.log make -j$(nproc)
    popd

    touch tcc.compiled
fi
echo ":: TinyCC compiled"

popd
