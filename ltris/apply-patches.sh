
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Debian
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/10-remove-inline-for-GCC5.patch

set +e +o pipefail
