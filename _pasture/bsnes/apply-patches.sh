
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z.ao --verbose -i ${SB_PATCHDIR}/bsnes-0.064-ao.patch

set +e +o pipefail
