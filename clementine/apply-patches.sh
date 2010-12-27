
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .pofix --verbose -i ${SB_PATCHDIR}/${NAME}-0.4.2-pofix.patch
# Use system echonest instead of the bundled copy
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-system-libechonest.patch
# Don't install Ubuntu icons
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-no-ubuntu-icons.patch

set +e +o pipefail
