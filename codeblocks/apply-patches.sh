  
SB_PATCHDIR=${CWD}/patches

# bug #461120 (http://developer.berlios.de/patch/?func=detailpatch&patch_id=2568&group_id=5358)
zcat ${SB_PATCHDIR}/${NAME}-run.patch.gz | patch -p0 -E --backup --verbose || exit 1
# bug #469096 (fixed in upstream svn revision 5159)
zcat ${SB_PATCHDIR}/${NAME}-8.02-gcc-detect.patch.gz | patch -p0 -E --backup --verbose || exit 1
# fix for gcc 4.4/glibc 2.9.90 http://developer.berlios.de/patch/index.php?func=detailpatch&patch_id=2699&group_id=5358
zcat ${SB_PATCHDIR}/${NAME}-drop-const.patch.gz | patch -p1 -E --backup --verbose || exit 1
