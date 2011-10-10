
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gdbm-1.9.1-zeroheaders.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gdbm-1.9.1-shortread.patch

set +e +o pipefail
