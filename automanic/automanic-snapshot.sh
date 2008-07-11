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

cd "$tmp"
svn checkout -r {$svn} https://automanic.svn.sourceforge.net/svnroot/automanic/trunk automanic automanic-$svn
cd automanic-$svn
./version.sh .
find . -type d -name .svn -print0 | xargs -0r rm -rf
cd ..
tar jcf "$pwd"/automanic-$svn.tar.bz2 automanic-$svn
cd - >/dev/null
