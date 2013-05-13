
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00-fix-ftbfs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/05_dont_pkg_check_python.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
