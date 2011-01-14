
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Avoid buffer overflow report from glibc with FORTIFY_SOURCE
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-curl-7.21.3-tftpd-buffer-overflow.patch
# patch making libcurl multilib ready
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0101-curl-7.21.1-multilib.patch
# prevent configure script from discarding -g in CFLAGS
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0102-curl-7.21.2-debug.patch
# use localhost6 instead of ip6-localhost in the curl test-suite
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0104-curl-7.19.7-localhost6.patch
# exclude test1112 from the test suite (#565305)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0105-curl-7.21.3-disable-test1112.patch
rm -f tests/data/test1112
# disable valgrind for certain test-cases (libssh2 problem)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0106-curl-7.21.0-libssh2-valgrind.patch

set +e +o pipefail
