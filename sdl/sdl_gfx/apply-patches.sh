
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${PNAME}-2.0.13-ppc.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
