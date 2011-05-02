
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Upstream patches
zcat ${SB_PATCHDIR}/mozilla-191-path.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/mozilla-jemalloc.patch.gz | patch -p0 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cstddef.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mozilla-comodo-646460.patch

set +e +o pipefail
