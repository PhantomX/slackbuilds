#!/bin/sh

set -e

tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
    set +e
    [ -z "$tmp" -o ! -d "$tmp" ] || rm -rf "$tmp"
}

unset CDPATH
pwd=$(pwd)
BVERSION=2.49b

pushd "$tmp"
if [ -e $pwd/blender-${BVERSION}.tar.gz ] ; then
tar zxvf $pwd/blender-${BVERSION}.tar.gz
fi

pushd blender-${BVERSION}
pushd extern
#Removed because of ip
  rm -rf ffmpeg libmp3lame x264 xvidcore
#Removed because we can expect to use system one
#  rm -rf fftw glew libopenjpeg ode qhull make verse
#Will have to be removed later: bFTGL
popd
rm -rf scons
popd

tar jcf "$pwd"/blender-${BVERSION}-repack.tar.bz2 blender-${BVERSION}


popd
