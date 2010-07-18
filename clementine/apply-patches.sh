
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .pofix --verbose -i ${SB_PATCHDIR}/${NAME}-0.4.2-pofix.patch

## https://bugzilla.redhat.com/show_bug.cgi?id=583327
# The next 3 are to split out the bundled libraries
# http://code.google.com/p/clementine-player/source/detail?r=1443
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-system-projectM.patch
# http://code.google.com/p/clementine-player/source/detail?r=1444
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-system-qtsingleapplication.patch
# http://code.google.com/p/clementine-player/source/detail?r=1445
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-system-qtiocompressor.patch
# Also split qxt. This is still under discussion with upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-split-qxt.patch
# http://code.google.com/p/clementine-player/issues/detail?id=291#c22
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-font-paths.patch

set +e +o pipefail
