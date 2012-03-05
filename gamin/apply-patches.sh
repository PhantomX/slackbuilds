
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gamin-manape.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gamin-0.1.11-double-lock.patch

set +e +o pipefail
