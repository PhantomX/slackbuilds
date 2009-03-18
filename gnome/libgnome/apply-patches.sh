
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/default-background-dir.patch.gz | patch -p1 -E --backup --verbose || exit 1
if [ "${SB_SLKART}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/slk-default-background.patch.gz | patch -p1 -E --backup --verbose || exit 1
else
  zcat ${SB_PATCHDIR}/orig-default-background.patch.gz | patch -p1 -E --backup --verbose || exit 1
fi
# zcat ${SB_PATCHDIR}/${NAME}-2.11.1-scoreloc.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.7.2-default-cursor.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.8.0-default-browser.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.19.1-default-settings.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-2.22.0-default-sound-effects.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/im-setting.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.24.1-default-noblink.patch.gz | patch -p1 -E --backup --verbose || exit 1
