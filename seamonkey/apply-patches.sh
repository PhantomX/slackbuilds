
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -d mozilla/gfx/cairo/cairo -i ${SB_PATCHDIR}/01_fix_slowness.patch
patch -p2 -E --backup --verbose -d mozilla -i ${SB_PATCHDIR}/xulrunner-15.0-gcc47.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/seamonkey-8.0-enable-addons.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/seamonkey-idl-parser-cachepath.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/seamonkey-2.15-rhbz_304121.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/seamonkey-2.14-installdir.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/seamonkey-2.14-elfhack.patch

patch -p1 -E --backup --verbose -d mozilla -i ${SB_PATCHDIR}/mozilla-239254.patch

# OpenSUSE
patch -p1 -E --backup --verbose -d mozilla -i ${SB_PATCHDIR}/mozilla-gstreamer-760140.patch
patch -p1 -E --backup --verbose -d mozilla -i ${SB_PATCHDIR}/mozilla-nongnome-proxies.patch

set +e +o pipefail
