
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -d mozilla/gfx/cairo/cairo -i ${SB_PATCHDIR}/01_fix_slowness.patch
patch -p2 -E --backup --verbose -d mozilla -i ${SB_PATCHDIR}/xulrunner-26.0-gcc47.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-32-rhbz-966424.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-32-mozilla-858919.patch
case "${ARCH}" in
  i[3-6]86)
    patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-32-baseline-disable.patch
    ;;
esac
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/seamonkey-2.29-enable-addons.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/seamonkey-2.26-installdir.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/seamonkey-2.25-elfhack.patch

# Gentoo

# OpenSUSE
patch -p1 -E --backup --verbose -d mozilla -i ${SB_PATCHDIR}/mozilla-nongnome-proxies.patch
patch -p1 -E --backup --verbose -d mozilla -i ${SB_PATCHDIR}/mozilla-icu-strncat.patch

set +e +o pipefail
