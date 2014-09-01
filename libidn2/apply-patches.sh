
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .rpath --verbose -i ${SB_PATCHDIR}/libidn2-0.3-rpath.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
