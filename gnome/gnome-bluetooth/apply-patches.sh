
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.32.0-libnotify-0.7.patch
# Fix build with gobject-introspection 0.9, bug #344227
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.32.0-introspection-build.patch
# Fix nautilus-sendto automagic support, upstream bug #639130
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.32.0-nsd-automagic.patch

set +e +o pipefail
