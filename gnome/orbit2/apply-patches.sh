
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/ORBit2-2.14.3-multilib.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/ORBit2-2.14.3-ref-leaks.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
