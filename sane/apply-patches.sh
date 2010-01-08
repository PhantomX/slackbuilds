  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/sane-backends-1.0.20-rpath.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sane-backends-1.0.20-pkgconfig.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sane-backends-1.0.20-open-macro.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sane-backends-1.0.20-hal.patch.gz | patch -p1 -E --backup --verbose || exit 1
if [ "${SB_UACL}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/sane-backends-1.0.20-udev.patch.gz | patch -p1 -E --backup --verbose || exit 1
fi
zcat ${SB_PATCHDIR}/sane-backends-1.0.20-man-utf8.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sane-backends-1.0.20-epson-expression800.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sane-backends-1.0.20-lockdir.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sane-backends-1.0.20-genesys-gl841-registers.patch.gz | patch -p1 -E --backup --verbose || exit 1
bzcat ${CWD}/sane-backends-1.0.20-autoreconf.patch.bz2 | patch -p1 -E --backup --verbose || exit 1

