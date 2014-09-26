
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-gcc47.patch
patch -p1 -R -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-revert-types.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
