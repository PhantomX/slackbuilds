  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/sane-backends-1.0.20-rpath.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sane-backends-1.0.20-pkgconfig.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sane-backends-1.0.20-open-macro.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sane-backends-1.0.20-man-utf8.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sane-backends-1.0.20-epson-expression800.patch.gz | patch -p1 -E --backup --verbose || exit 1
bzcat ${CWD}/sane-backends-1.0.20-autoreconf.patch.bz2 | patch -p1 -E --backup --verbose || exit 1

