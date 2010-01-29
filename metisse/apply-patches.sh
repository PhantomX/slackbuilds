
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-20061130-fixcursor.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-20061130-background.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-20061201-a11y.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-defaults.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.4.0-rc4-textdomain.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.4.1-format-security.patch.gz | patch -p1 -E --backup --verbose || exit 1

if pkg-config --exists libpng14 ;then
  zcat ${SB_PATCHDIR}/metisse-0.4.1-png14.patch.gz | patch -p0 -E --backup --verbose || exit 1
fi
