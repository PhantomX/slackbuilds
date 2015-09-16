
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gimp-2.8.14-gegl-0.3.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
