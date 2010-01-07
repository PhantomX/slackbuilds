  
SB_PATCHDIR=${CWD}/patches

# Stop issuing lone zero block warnings
zcat ${SB_PATCHDIR}/${NAME}.nolonezero.diff.gz | patch -p1 --verbose || exit 1
# Fix extracting sparse files to a filesystem like vfat,
# when ftruncate may fail to grow the size of a file.(rh #179507)
zcat ${SB_PATCHDIR}/${NAME}-1.15.1-vfatTruncate.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.19-xattrs.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Add support for selinux, acl and extended attributes
zcat ${SB_PATCHDIR}/${NAME}-1.19-xattrs-conf.patch.gz | patch -p1 -E --backup --verbose || exit 1
# --wildcards-match-slash" for compatibility reasons
zcat ${SB_PATCHDIR}/${NAME}-1.17-wildcards.patch.gz | patch -p1 -E --backup --verbose || exit 1
# ignore errors from setting utime() for source file on read-only filesystem
zcat ${SB_PATCHDIR}/tar-1.22-atime-rofs.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Report record size only if the archive refers to a device(rh #487760)
zcat ${SB_PATCHDIR}/tar-1.22-shortreadbuffer.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Do not sigabrt with new gcc/glibc because of writing to
# struct members of gnutar header at once via strcpy
zcat ${SB_PATCHDIR}/tar-1.22-fortifysourcessigabrt.patch.gz | patch -p1 -E --backup --verbose || exit 1
# fix memory leak in xheader (rh #518079)
zcat ${SB_PATCHDIR}/tar-1.22-xheaderleak.patch.gz | patch -p1 -E --backup --verbose || exit 1
# fix segfault in code_ns_fraction() with corrupted metadata (rh #531441)
#zcat ${SB_PATCHDIR}/tar-1.22-nsfraction.patch.gz | patch -p1 -E --backup --verbose || exit 1
# update gnulib's utimens module to latest version to prevent utimens() bad file
# descriptor failures with POSIX2008 glibc
zcat ${SB_PATCHDIR}/tar-1.22-utimens.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-1.22-xz-support.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.22-support_txz.diff.gz | patch -p1 -E --backup --verbose || exit 1
