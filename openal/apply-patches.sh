  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-no-undefined.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-pkgconfig.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-pause.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-gcc43.patch.gz | patch -p1 -E --backup --verbose || exit 1

sh ./autogen.sh || exit 1

zcat ${SB_PATCHDIR}/${NAME}-arch.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${CWD}/${NAME}-x86_64-mmx.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/002_all_alsa_default.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Fix MMX related crashes
zcat ${SB_PATCHDIR}/003_all_mmx.patch.gz | patch -p0 -E --backup --verbose || exit 1
