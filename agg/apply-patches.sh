
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/agg-2.4-depends.patch
zcat ${SB_PATCHDIR}/agg-2.5-pkgconfig.patch.gz | patch -p1 -E --backup --verbose || exit 1
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/agg-2.5-autotools.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-non-terminating-loop-conditions-when-len-1.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Cure-recursion-by-aborting-if-the-co-ordinates-are-t.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-Get-coordinates-from-previous-vertex-if-last-command.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-Make-rasterizer_outline_aa-ignore-close_polygon-when.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-Remove-VC-6-workaround.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0006-Implement-grain-merge-blending-mode-GIMP.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0007-Implement-grain-extract-blending-mode-GIMP.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0008-Declare-multiplication-and-division-operators-as-con.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0009-Add-a-static-identity-transformation.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0010-Add-renderer_scanline_aa_alpha.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0011-Avoid-division-by-zero-in-color-burn-mode.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
