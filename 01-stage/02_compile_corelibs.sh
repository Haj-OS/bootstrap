#!/bin/sh

. utils/dirstack
. utils/err
. utils/exists
. utils/logger

# if ! exists tcc; then
#     err "Please install tcc"
#     exit 1
# fi

if ! exists make; then
    err "Please install make"
    exit 1
fi

pushd sources

if ! [ -f "corelibs.compiled" ]; then
    pushd corelibs 
    echo ":: Compiling corelibs"
    log_both corelibs.compilation.log make
    popd

    touch corelibs.compiled
fi
echo ":: Corelibs compiled"

popd
