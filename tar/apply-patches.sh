
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
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.15.1-vfatTruncate.patch
# --wildcards-match-slash" for compatibility reasons
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.17-wildcards.patch
# ignore errors from setting utime() for source file on read-only filesystem
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.22-atime-rofs.patch
# Fix for bad cooperation of -C and -u options.
# ~> #688567
# ~> http://lists.gnu.org/archive/html/bug-tar/2012-02/msg00007.html
# ~> still downstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.26-update-with-change-directory.patch
# Do not print xattrs/selinux/acls when --no-xattrs/--no-acls/--no-selinux
# options are used during -tvv output.  (TODO: merge this with xattrs patch
# once becomes upstream)
# ~> downstream (yet)
# ~> proposal: http://lists.gnu.org/archive/html/bug-tar/2013-05/msg00020.html
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.26-xattrs-printing.patch
# The --xattrs-include or --xattrs-exclude options should imply --xattrs.
# ~> still downstream
#    http://lists.gnu.org/archive/html/bug-tar/2013-05/msg00020.html
# ~> #965969
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.26-xattrs-include-implies-xattrs.patch

set +e +o pipefail
