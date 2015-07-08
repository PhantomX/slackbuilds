
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
# Allow treat read() errors by changing type of input_size to signed integer.
# ~> downstream
# ~> http://lists.gnu.org/archive/html/bug-cpio/2013-09/msg00005.html
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cpio-2.11-treat-read-errors.patch
# heap-based buffer overrun
# ~> #1167573
# ~> upstream: git diff 3945f9db..58df4f1b
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cpio-2.11-CVE-2014-9112.patch
# Related to CVE-2014-9112 patch.
# ~> reported upstream:
#    http://lists.gnu.org/archive/html/bug-cpio/2014-12/msg00005.html
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cpio-2.11-testsuite-CVE-2014-9112.patch

set +e +o pipefail
