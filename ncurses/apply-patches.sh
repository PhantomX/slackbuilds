
SB_PATCHDIR=${CWD}/patches

bzcat ${SB_PATCHDIR}/${NAME}-5.6-20080621-patch.sh.bz2 | patch -p1 --verbose || exit 1
rm -rf tack
for file in ${SB_PATCHDIR}/${NAME}-${VERSION}-2???????.patch.gz ; do
  zcat ${file} | patch -p1 --verbose || exit 1
done

zcat ${SB_PATCHDIR}/${NAME}.mkhashsize.diff.gz | patch -p1 --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-5.5-20061209-config.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.6-20070612-libs.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.6-20080112-xterm.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.6-20080112-urxvt.patch.gz | patch -p1 --verbose || exit 1

