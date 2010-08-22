
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
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-font-paths-slk.patch
# Fix lastFM crash RHBZ#618474
# http://code.google.com/p/clementine-player/issues/detail?id=463
# From upstream trunk
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-fix-lastfm-crash.patch
# Enforce Fedora specific optimization flags. Accepted by upstream.
# http://code.google.com/p/clementine-player/source/detail?r=1639
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-fix-buildflags.patch
# Only create the OpenGL graphics context when you first open the visualisations
# window. Fixes RHBZ#621913. From upstream trunk:
# http://code.google.com/p/clementine-player/source/detail?spec=svn1661&r=1431
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-visualization-init.patch

set +e +o pipefail
