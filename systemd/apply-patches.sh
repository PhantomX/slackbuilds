
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -R -E --backup --verbose -i ${SB_PATCHDIR}/0001-unit-fix-complementing-of-requirement-deps-with-Afte.patch

set +e +o pipefail
