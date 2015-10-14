
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Debian
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Makefile.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/buffer-overflow.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/FTBFS-with-fread.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/clang-FTBFS.patch

zcat ${SB_PATCHDIR}/${NAME}-0.8.2-mandest.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.8.2-utils-werror.patch.gz | patch -p0 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.8.2-png15.patch

set +e +o pipefail
