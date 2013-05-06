
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
cp -f lib/packer.h lib/packer.h.in
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cracklib-2.8.15-inttypes.patch

sed -i -e 's|AM_CONFIG_HEADER|AC_CONFIG_HEADERS|g' configure.in || exit 1

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
