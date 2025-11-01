#!/bin/sh

. utils/dirstack

rm -rf rootfs

echo ":: Preparing root filesystem"

mkdir -p rootfs sources logs
pushd rootfs

echo ":: Creating directories"

mkdir boot dev etc home mnt proc root sys tmp usr var
mkdir -p usr/bin usr/include usr/lib usr/sbin usr/share
mkdir -p usr/local/bin usr/local/include usr/local/lib usr/local/sbin usr/local/share
for dir in bin lib sbin; do
    ln -s usr/$dir $dir
done

echo ":: Linking sources to /usr/src"
ln -s ../../sources usr/src

popd
