
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gnupg-2.0.16-tests-s2kcount.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gnupg-2.0.14-secmem.patch

## upstream patches

set +e +o pipefail
