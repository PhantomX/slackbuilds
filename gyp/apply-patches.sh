
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Adapted from Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gyp-slkcflags.patch

set +e +o pipefail
