  
SB_PATCHDIR=${CWD}/patches

# Fix errors when compiling with gcc >= 4.3
zcat ${SB_PATCHDIR}/${NAME}-1.0-gcc43.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Don't put build cflags in .pc
zcat ${SB_PATCHDIR}/${NAME}-1.0-remove-pc-cflags.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Install docs into DESTDIR
zcat ${SB_PATCHDIR}/${NAME}-1.0-fix-doc-dest.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Don't try to build snprintf.c
#zcat ${SB_PATCHDIR}/${NAME}-1.0-no-snprintf.patch.gz | patch -p1 -E --backup --verbose || exit 1
#rm -rf src/snprintf.c
