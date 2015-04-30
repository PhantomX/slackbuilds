
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
# implement public key pinning for NSS backend
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-curl-7.42.1-b47c17d6.patch
# patch making libcurl multilib ready
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0101-curl-7.32.0-multilib.patch
# prevent configure script from discarding -g in CFLAGS
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0102-curl-7.36.0-debug.patch
# use localhost6 instead of ip6-localhost in the curl test-suite
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0104-curl-7.19.7-localhost6.patch

# work around valgrind bug (#678518)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0107-curl-7.21.4-libidn-valgrind.patch
# Fix character encoding of docs, which are of mixed encoding originally so
# a simple iconv can't fix them
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0108-curl-7.32.0-utf8.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
