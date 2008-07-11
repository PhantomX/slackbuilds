#!/bin/bash

set -e

tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
    set +e
    [ -z "$tmp" -o ! -d "$tmp" ] || rm -rf "$tmp"
}

unset CDPATH
pwd=$(pwd)
ver=0.1.7

cd "$tmp"
wget -N http://downloads.sourceforge.net/oyranos/oyranos-${ver}.tar.gz
tar zxvf oyranos-${ver}.tar.gz
pushd oyranos-${ver}
# Prevent static elektra to be used
rm -rf elektra-0.6.4
# Prevent static libXNVCtrl to be used
rm -rf libXNVCtrl libXNVCtrl.a
# Make build more verbose
for f in `find . -name [mM]akefile\*` configure.sh ; do sed -i.silent -e '/.SILENT/d' $f ; done
# Fix Changelog not-utf8
cp -p ChangeLog ChangeLog.origine
iconv -f ISO-8859-1 -t UTF8 ChangeLog.origine >  ChangeLog
touch -r ChangeLog.origine ChangeLog
rm -rf ChangeLog.origine
# Remove icc profiles from the archive
rm -rf standard_profiles
popd
tar jcf "$pwd"/oyranos-repack-${ver}.tar.bz2 oyranos-${ver}
cd - >/dev/null
