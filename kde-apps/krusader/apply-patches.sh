
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://sourceforge.net/tracker/?func=detail&aid=2873567&group_id=6488&atid=306488
# adds XZ support to KrArc and the packing/unpacking functionality (#593525 part 1)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.2.0-beta1-xz.patch
# https://sourceforge.net/tracker/?func=detail&atid=306488&aid=3011061&group_id=6488
# adds default MIME type handlers for LZMA and XZ archives (#593525 part 2)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.2.0-beta1-default-mimetypes-xz.patch
# fix regression making single-click mode unusable
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.2.0-beta1-singleclick-regression.patch
# fix regression: "rename selects extension" not working (SF#3003338)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.2.0-beta1-rename-selects-ext-regression.patch
# force reloading when opening a file in the viewer (SF#2969403)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.2.0-beta1-force-reload.patch
# fix bogus toplevel entries being shown in the viewer menu (SF#2981303)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.2.0-beta1-viewer-menu.patch
# fix the text viewer not being read-only (SF#2898151)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.2.0-beta1-readonly.patch
# fix Krusader not terminating properly (#620328, kde#240319, SF#3015094)
# (patch backported from upstream SVN trunk)
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.2.0-beta1-fix-hang-on-close.patch

set +e +o pipefail
