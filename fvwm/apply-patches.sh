# The set of patches from hell :)

set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-2.5.28-xdg-open.patch.gz | patch -p1 -E --backup --verbose
#zcat ${SB_PATCHDIR}/${NAME}-2.5.21-htmlview.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.5.28-mimeopen.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.5.21-menu-generate.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.5.24-module_list_remove.patch.gz | patch -p0 -E --backup --verbose

# this patch enables fast translucent menus in fvwm. this is a
# minor tweak of a patch posted to fvwm-user mailing list by Olivier
# Chapuis in <20030827135125.GA6370@snoopy.folie>.
zcat ${SB_PATCHDIR}/${NAME}-2.5.23-translucent-menus.diff.gz | patch -p0 -E --backup --verbose

zcat ${SB_PATCHDIR}/03-ColourBorders.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/04-ResizeOutlineThin.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/05-Conditionals.patch.gz | patch -p0 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/06-FlatSeparators.patch
zcat ${SB_PATCHDIR}/07-BorderUnderTitle.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/08-InactiveFont.patch.gz | patch -p0 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/09-FluxRoundedCorners.patch
zcat ${SB_PATCHDIR}/10-TopBorder.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/11-ButtonWidth.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/12-MultiBorder.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/13-FvwmButtonsTips.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/14-FvwmIconMan.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/15-Hover.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/16-FirstItemUnderPointer.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/17-TextOffset.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/18-ThinGeometryProxy.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
