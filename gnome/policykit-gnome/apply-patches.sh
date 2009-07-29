  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${PNAME}-0.8-dont-spawn-when-running-under-gdm.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-0.9.2-fix-clickable-buttons.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-0.9.2-i18ninit.patch.gz | patch -p1 -E --backup --verbose || exit 1
# (fc) 0.9.2-2mdv fix for use with non UTF8 locale
zcat ${SB_PATCHDIR}/${PNAME}-0.9.2-nonutf8.patch.gz | patch -p1 -E --backup --verbose || exit 1
