
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.23-makefile_nostaticlibs.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.45.02-gcc_no_libstdc++.patch
[ "${SB_RD}" = "YES" ] && patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.44.02-runtime-detection.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.43-ftbs_ld_libm.patch

set +e +o pipefail
