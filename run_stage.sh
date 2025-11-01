#!/bin/sh

. utils/err

stages=$(find . -type d -name "*-stage" | sed "s/\.\///" | sort -n)

if ! [ -d rootfs ]; then
    err "Please run ./prepare.sh first"
    exit 1
fi

export SRCDIR=$(pwd)
export ROOTFS=$(pwd)/rootfs

. ./envs

mkdir -p sources

while true; do
    echo "Select stage to scaffold: "
    for stage in $stages; do
        echo "Stage: $(echo $stage | cut -d"-" -f1)"
    done
    printf "Select: "

    read stage 

    if ! [ -d "$stage-stage" ]; then
        err "\nUknown stage $stage, try again"
    else
        break
    fi
done

for script in $(find "$stage-stage/" -type f | sort -n); do
    echo ":: Running step $(basename $script)"
    "$script"
done
