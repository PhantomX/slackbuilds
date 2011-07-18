
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gdbm-1.8.3-zeroheaders.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gdbm-1.8.3-fhs-slk.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gdbm-1.8.3-shortread.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gdbm-1.8.3-ndbmlock.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gdbm-1.8.3-filestruct.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gdbm-1.8.3-build.patch

set +e +o pipefail
