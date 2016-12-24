
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lz4-shared.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-fix-make-concurrency-build-277.patch

set +e +o pipefail
