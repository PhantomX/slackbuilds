
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
( cd ${NCSRCDIR}
  zcat ${SB_PATCHDIR}/${NAME}-1.13.bzip2.diff.gz | patch -p1 --verbose
  zcat ${SB_PATCHDIR}/tar-1.13-fortifysourcessigabrt.patch.gz | patch -p1 -E --backup --verbose
)
# Stop issuing lone zero block warnings
zcat ${SB_PATCHDIR}/${NAME}.nolonezero.diff.gz | patch -p1 --verbose
# Fix extracting sparse files to a filesystem like vfat,
# when ftruncate may fail to grow the size of a file.(rh #179507)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.15.1-vfatTruncate.patch
# --wildcards-match-slash" for compatibility reasons
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.17-wildcards.patch
# ignore errors from setting utime() for source file on read-only filesystem
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.22-atime-rofs.patch
#oldarchive option was not working(#594044)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.23-oldarchive.patch
# Fix for bad cooperation of -C and -u options.
# ~> #688567
# ~> http://lists.gnu.org/archive/html/bug-tar/2012-02/msg00007.html
# ~> still downstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.26-update-with-change-directory.patch
# Fix rawhide build failure with undefined gets.
# ~> upstream (gnulib)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.26-stdio.in.patch
# Fix regression with --keep-old-files option.
# ~> #799252
# ~> http://lists.gnu.org/archive/html/bug-tar/2011-11/msg00043.html
# ~> upstream (7a5a3708c)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.26-add-skip-old-files-option.patch
# Prepare included gnulib library for SELinux support.
# -> Related to the next patch.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.26-selinux-gnulib.patch
# Add support for extended attributes, SELinux and POSIX ACLs.
# ~> Original implementation #200925
# ~> http://lists.gnu.org/archive/html/bug-tar/2012-08/msg00012.html
# ~> upstream (b997c90f9, 696338043, d36f5a3cc, 085cace18, up-to ~> 83701a590)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.26-xattrs.patch
# Fix problem with bit UIDs/GIDs (> 2^21) and --posix format.
# ~> rh#913406
# ~> upstream (it is part of df7b55a8f6354e)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.26-posix-biguid.patch
# Allow store sparse files of effective size >8GB into pax archives
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.26-pax-big-sparse-files.patch
# Fix: Allow extracting single volume in a multi-volume archive
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.26-allow-extract-single-volume.patch
# Allow to pass arguments to commands called from tar
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/tar-1.26-command-args.patch

# Adds txz support
zcat ${SB_PATCHDIR}/${NAME}-1.23-support_txz.diff.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
