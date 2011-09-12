
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fixes some compilation errors with gcc 4.4
patch -p1 -E --backup -z .gcc46 --verbose -i ${SB_PATCHDIR}/${NAME}-gcc46.patch

set +e +o pipefail
