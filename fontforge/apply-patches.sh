
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-20090224-pythondl.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20100501-select-points-crash.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20110222-libpng15.patch

set +e +o pipefail
