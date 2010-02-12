  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-upstream_branch_slideshow_icon_fix.diff.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-upstream_branch_1bpp_bmp_fix.diff.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-exif_crash_fix_KDE159522.diff.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.4.2-exiv2.patch.gz | patch -p0 -E --backup --verbose || exit 1
