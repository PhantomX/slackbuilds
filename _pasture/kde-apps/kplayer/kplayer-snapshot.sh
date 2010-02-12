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
cvs=$(date +%Y%m%d)cvs
name=kplayer

cd "$tmp"
cvs -z3 -d:pserver:anonymous@kplayer.cvs.sourceforge.net:/cvsroot/kplayer export -D $(date +%Y%m%d) $name
cd $name
version=$(cat ChangeLog |grep release|awk '{print $1}'|awk 'NR == 1')
cd ..
tar jcf "$pwd"/$name-$version-$cvs.tar.bz2 $name
echo "Written: $name-$version-$cvs.tar.bz2"
cd - >/dev/null
