
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
# patch making libcurl multilib ready
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0101-curl-7.32.0-multilib.patch
# prevent configure script from discarding -g in CFLAGS
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0102-curl-7.36.0-debug.patch
# make the curl tool link SSL libraries also used by src/tool_metalink.c
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0103-curl-7.36.0-metalink.patch
# use localhost6 instead of ip6-localhost in the curl test-suite
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0104-curl-7.19.7-localhost6.patch
# disable valgrind for certain test-cases (libssh2 problem)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0106-curl-7.36.0-libssh2-valgrind.patch
# work around valgrind bug (#678518)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0107-curl-7.21.4-libidn-valgrind.patch
# Fix character encoding of docs, which are of mixed encoding originally so
# a simple iconv can't fix them
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0108-curl-7.32.0-utf8.patch
# fix endless loop with GSSAPI proxy auth (patches by David Woodhouse, #1118751)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-curl-7.37.1-gssapi.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
