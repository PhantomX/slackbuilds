
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# SVR4 portable format as default .
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cpio-2.9-rh.patch
# fix warn_if_file_changed() and set exit code to 1 when cpio
# fails to store file > 4GB (#183224)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cpio-2.9-exitCode.patch
# Support major/minor device numbers over 127 (bz#450109)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cpio-2.9-dev_number.patch
# define default remote shell as /usr/bin/ssh(#452904)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cpio-2.9.90-defaultremoteshell.patch
# fix segfault with nonexisting file with patternnames(#567022)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cpio-2.10-patternnamesigsegv.patch
# fix bad file name splitting while creating ustar archive (#866467)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cpio-2.10-longnames-split.patch

set +e +o pipefail
