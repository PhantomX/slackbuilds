
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .pofix --verbose -i ${SB_PATCHDIR}/${NAME}-0.4.2-pofix.patch
# http://code.google.com/p/clementine-player/issues/detail?id=798
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-no-qtwin.patch
# http://code.google.com/p/clementine-player/source/detail?r=2063
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-gst-safeguard.patch

set +e +o pipefail
