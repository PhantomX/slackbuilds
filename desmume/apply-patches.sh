
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fix gdk_cairo_create miscompilation segfault
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.9.10-fix-segfault.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
