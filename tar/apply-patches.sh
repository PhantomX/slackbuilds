
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
( cd ${NCSRCDIR}
  zcat ${SB_PATCHDIR}/${NAME}-1.13.bzip2.diff.gz | patch -p1 --verbose
  zcat ${SB_PATCHDIR}/tar-1.13-fortifysourcessigabrt.patch.gz | patch -p1 -E --backup --verbose
)
# Stop issuing lone zero block warnings
zcat ${SB_PATCHDIR}/${NAME}.nolonezero.diff.gz | patch -p1 --verbose

### Fedora
# Fix extracting sparse files to a filesystem like vfat,
# when ftruncate may fail to grow the size of a file.(rh #179507)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.28-vfatTruncate.patch
# --wildcards-match-slash" for compatibility reasons
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.29-wildcards.patch
# ignore errors from setting utime() for source file on read-only filesystem
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.28-atime-rofs.patch
# Fix for bad cooperation of -C and -u options.
# ~> #688567
# ~> http://lists.gnu.org/archive/html/bug-tar/2012-02/msg00007.html
# ~> still downstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.28-update-with-change-directory.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.28-document-exclude-mistakes.patch
# Fix for infinite loops during sparse file handling
# ~> dowstream
#    http://www.mail-archive.com/bug-tar@gnu.org/msg04432.html
# ~> #1082608
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.28-sparse-inf-loops.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.29-create-and-xattrs-exclude.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.29-xattrs-and-skip-old-files.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
