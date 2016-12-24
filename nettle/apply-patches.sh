
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nettle-3.2-version-h.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nettle-3.3-remove-ecc-testsuite.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
