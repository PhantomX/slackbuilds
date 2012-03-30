
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libzip-0.10_rc1-fix_headers.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libzip-0.10-php.patch

set +e +o pipefail
