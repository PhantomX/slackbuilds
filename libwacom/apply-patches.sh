
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-data-add-ISDV4-5040-Lenovo-X1-Yoga.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
