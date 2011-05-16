
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/wesnoth-1.2.8-gcc43.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.8.5-cstddef.patch

set +e +o pipefail
