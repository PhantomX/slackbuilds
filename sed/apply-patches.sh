
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sed-4.2.1-copy.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sed-4.2.1-makecheck.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sed-4.2.1-data-loss.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sed-4.2.1-fix-0x26-on-RHS.patch

set +e +o pipefail
