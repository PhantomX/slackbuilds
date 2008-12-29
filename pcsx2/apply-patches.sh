  
SB_PATCHDIR=${CWD}/patches

# Preserve custom CFLAGS passed to configure.
zcat ${SB_PATCHDIR}/${NAME}-custom-cflags.patch.gz | patch -p0 -E --backup --verbose || exit 1
# Add nls support to the configure script.
zcat ${SB_PATCHDIR}/${NAME}-add-nls.patch.gz | patch -p0 -E --backup --verbose || exit 1
# Allow plugin inis to be stored in ~/.pcsx2/inis.
zcat ${SB_PATCHDIR}/${NAME}-plugin-inis.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-gcc43.patch.gz | patch -p1 -E --backup --verbose || exit 1
