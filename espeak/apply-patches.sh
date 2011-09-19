
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.23-makefile_nostaticlibs.patch.gz | patch -p1 -E --backup --verbose
[ "${SB_RD}" = "YES" ] && patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.45.05-runtime-detection.patch

set +e +o pipefail
