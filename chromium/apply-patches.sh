  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/0.9.12-gcc3-gentoo.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0.9.12-freealut.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0.9.12-configure.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0.9.12-png.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-src-0.9.12-qt3.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Supersed by png patch
#zcat ${SB_PATCHDIR}/${NAME}-0.9-zlib.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-src-0.9.12-libtool.patch.gz | patch -p1 -E --backup --verbose || exit 1
