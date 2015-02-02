
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# From Gentoo
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cairo-respect-fontconfig.patch

### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-xlib-Don-t-crash-when-swapping-a-0-sized-glyph.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-xcb-Don-t-crash-when-swapping-a-0-sized-glyph.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cairo-multilib.patch
# http://cgit.freedesktop.org/cairo/patch/src/cairo-image-compositor.c?id=5c82d91a5e15d29b1489dcb413b24ee7fdf59934
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cairo-fix_crash_in_fill_xrgb32_lerp_opaque_spans.patch

set +e +o pipefail
