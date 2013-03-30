
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# SVR4 portable format as default .
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cpio-2.9-rh.patch
# fix warn_if_file_changed() and set exit code to 1 when cpio
# fails to store file > 4GB (#183224)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cpio-2.9-exitCode.patch
# when extracting archive created with 'find -depth',
# restore the permissions of directories properly (bz#430835)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cpio-2.9-dir_perm.patch
# Support major/minor device numbers over 127 (bz#450109)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cpio-2.9-dev_number.patch
# make -d honor system umask(#484997)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cpio-2.9-sys_umask.patch
# define default remote shell as /usr/bin/ssh(#452904)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cpio-2.9.90-defaultremoteshell.patch
# fix segfault with nonexisting file with patternnames(#567022)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cpio-2.10-patternnamesigsegv.patch
# fix rawhide buildfailure by updating gnulib's stdio.in.h
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cpio-2.11-stdio.in.patch
# fix bad file name splitting while creating ustar archive (#866467)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cpio-2.10-longnames-split.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cpio.32bit.crc.diff

set +e +o pipefail
