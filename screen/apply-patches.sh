
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.0.3-libs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.0.3-screenrc.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-ipv6.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-E3.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.0-suppress_remap.patch

set +e +o pipefail
