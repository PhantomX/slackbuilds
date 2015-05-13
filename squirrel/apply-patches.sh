
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-autotools.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.2.4-mem.patch

set +e +o pipefail
