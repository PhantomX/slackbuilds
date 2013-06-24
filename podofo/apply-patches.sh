
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fix build with lua 5.2, from Gentoo.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-lua52.patch

set +e +o pipefail
