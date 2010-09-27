
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/libcroco-0.6.1-multilib.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
