
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Stop issuing lone zero block warnings
zcat ${SB_PATCHDIR}/${NAME}.nolonezero.diff.gz | patch -p1 --verbose
# Fix extracting sparse files to a filesystem like vfat,
# when ftruncate may fail to grow the size of a file.(rh #179507)
zcat ${SB_PATCHDIR}/${NAME}-1.15.1-vfatTruncate.patch.gz | patch -p1 -E --backup --verbose
#zcat ${SB_PATCHDIR}/${NAME}-1.19-xattrs.patch.gz | patch -p1 -E --backup -z .xattrs --verbose
# Add support for selinux, acl and extended attributes
#zcat ${SB_PATCHDIR}/${NAME}-1.19-xattrs-conf.patch.gz | patch -p1 -E --backup --verbose
# --wildcards-match-slash" for compatibility reasons
zcat ${SB_PATCHDIR}/${NAME}-1.17-wildcards.patch.gz | patch -p1 -E --backup --verbose
# ignore errors from setting utime() for source file on read-only filesystem
zcat ${SB_PATCHDIR}/tar-1.22-atime-rofs.patch.gz | patch -p1 -E --backup --verbose
# Do not sigabrt with new gcc/glibc because of writing to
# struct members of gnutar header at once via strcpy
zcat ${SB_PATCHDIR}/tar-1.22-fortifysourcessigabrt.patch.gz | patch -p1 -E --backup --verbose
# fix segfault in code_ns_fraction() with corrupted metadata (rh #531441)
zcat ${SB_PATCHDIR}/tar-1.22-nsfraction.patch.gz | patch -p1 -E --backup --verbose

zcat ${SB_PATCHDIR}/${NAME}-1.23-support_txz.diff.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
