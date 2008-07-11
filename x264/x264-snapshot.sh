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
svn=$(date +%Y%m%d)

pushd "$tmp"
svn checkout -r {$svn} svn://svn.videolan.org/x264/trunk x264-$svn
pushd x264-$svn
./version.sh .
find . -type d -name .svn -print0 | xargs -0r rm -rf
popd
tar jcf "$pwd"/x264-$svn.tar.bz2 x264-$svn
popd >/dev/null
