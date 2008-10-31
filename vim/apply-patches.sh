
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-7.0-fixkeys.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-6.2-specsyntax.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-7.0-crv.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/xxd-locale.patch.gz | patch -p1 --verbose || exit 1
if [ "${SB_HUNSPELL}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/${NAME}-7.0-hunspell.patch.gz | patch -p1 --verbose || exit 1
fi

for i in $( seq -w ${PATCHLEVEL} ) ; do
  patch -p0 --backup --verbose -i ${SB_PATCHDIR}/updates/${SVER}.${i} || exit 1
done

zcat ${SB_PATCHDIR}/${NAME}-7.0-syntax.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-7.1-nowarnings.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-6.1-rh3.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-7.0-rclocation.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-6.4-checkhl.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-7.2-fstabsyntax.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-7.1-lib64.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-7.0-warning.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-7.0-syncolor.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-7.0-specedit.patch.gz | patch -p1 --verbose || exit 1
