  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/scim-pinyin-showallkeys.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/scim-pinyin-0.5.91-save-in-temp.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/scim-pinyin-0.5.91-fix-load.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/scim-pinyin-0.5.91-fix-ms-shuangpin.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/scim-pinyin-0.5.91-gcc43.patch.gz | patch -p1 -E --backup --verbose || exit 1
