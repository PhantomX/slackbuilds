  
SB_PATCHDIR=${CWD}/patches

# From Gentoo
zcat ${SB_PATCHDIR}/${NAME}-1.0.0-cross-linux.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.0.0-install-bindir.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.0.0-install-headers.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.0.0-optional-bluetooth.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-man.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.8.3-ppp.patch.gz | patch -p0 -E --backup --verbose || exit 1
