  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${PNAME}-1.4-libtoolize.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-1.4-subdir.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-1.4-backslash.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-1.4-tags.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-1.4-subdirs-89656.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-info.patch.gz | patch -p1 -E --backup --verbose || exit 1
mv automake.texi automake14.texi || exit 1
rm -f automake.info
