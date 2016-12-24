
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/libgcrypt-1.4.4-multilib.patch.gz | patch -p0 -E --backup --verbose
# use poll instead of select when gathering randomness
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libgcrypt-1.7.3-use-poll.patch
# slight optimalization of mpicoder.c to silence Valgrind (#968288)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libgcrypt-1.6.1-mpicoder-gccopt.patch
# do not use strict aliasing for bufhelp functions
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libgcrypt-1.7.3-aliasing.patch

set +e +o pipefail
