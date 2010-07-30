
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-girepository-Actually-verify-header-of-loaded-typeli.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/py2.7-compat.patch

set +e +o pipefail
