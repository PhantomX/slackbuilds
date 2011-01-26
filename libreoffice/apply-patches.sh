
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

( cd ${PKG}/usr/lib${LIBDIRSUFFIX}/${NAME}/program
  # Set to gtk/gnome as default, it is better then others.
  patch -p0 --backup -z .gnome --verbose -i ${CWD}/patches/ooo-force-desktop-gnome.patch
  rm -vf *.gnome
)

set +e +o pipefail
