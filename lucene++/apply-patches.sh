
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Add-support-for-compiling-with-c-11.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Turn-off-custom-allocator-by-default.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-Fix-accidental-use-of-operator-instead-of-operator.patch

set +e +o pipefail
