
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/xxp-0.5.3.3-xklavier-api.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
