
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Stop issuing lone zero block warnings
zcat ${SB_PATCHDIR}/${NAME}.nolonezero.diff.gz | patch -p1 --verbose
# Fix extracting sparse files to a filesystem like vfat,
# when ftruncate may fail to grow the size of a file.(rh #179507)
zcat ${SB_PATCHDIR}/${NAME}-1.15.1-vfatTruncate.patch.gz | patch -p1 -E --backup --verbose
# Add support for selinux, acl and extended attributes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.23-xattrs.patch
# --wildcards-match-slash" for compatibility reasons
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.17-wildcards.patch
# ignore errors from setting utime() for source file on read-only filesystem
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.22-atime-rofs.patch
# Do not sigabrt with new gcc/glibc because of writing to
# struct members of gnutar header at once via strcpy
zcat ${SB_PATCHDIR}/tar-1.22-fortifysourcessigabrt.patch.gz | patch -p1 -E --backup --verbose
#oldarchive option was not working(#594044)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.23-oldarchive.patch

# Adds txz support
zcat ${SB_PATCHDIR}/${NAME}-1.23-support_txz.diff.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
