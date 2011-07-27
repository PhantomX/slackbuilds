
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# From Debian
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/003_gdk.pc_privates.patch
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/015_default-fallback-icon-theme.patch
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/042_treeview_single-focus.patch
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/043_notebook_scroll.patch
patch -p1 --backup --verbose -i ${SB_PATCHDIR}/060_ignore-random-icons.patch

set +e +o pipefail
