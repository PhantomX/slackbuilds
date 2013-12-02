
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# fix slow progress bar on cards that do not implement server-side gradients
[ "${SB_LEGACY}" = "YES" ] && patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/01_fix_slowness.patch
# From Gentoo
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cairo-respect-fontconfig.patch

### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-xlib-Don-t-crash-when-swapping-a-0-sized-glyph.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-xcb-Don-t-crash-when-swapping-a-0-sized-glyph.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cairo-multilib.patch

set +e +o pipefail
