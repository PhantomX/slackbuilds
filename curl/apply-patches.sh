
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
# ssh: check md5 fingerprints case insensitively
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-curl-7.51.0-ssh-md5.patch
# stricter host name checking for file:// URLs
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-curl-7.51.0-file-host.patch
# map CURL_SSLVERSION_DEFAULT to NSS default, add support for TLS 1.3 (#1396719)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-curl-7.51.0-tls-version.patch
# patch making libcurl multilib ready
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0101-curl-7.32.0-multilib.patch
# prevent configure script from discarding -g in CFLAGS
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0102-curl-7.36.0-debug.patch
# use localhost6 instead of ip6-localhost in the curl test-suite
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0104-curl-7.19.7-localhost6.patch

# work around valgrind bug (#678518)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0107-curl-7.21.4-libidn-valgrind.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
