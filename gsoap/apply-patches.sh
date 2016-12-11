
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
[ "${SB_SHARED}" = "YES" ] && patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gsoap-libtool.patch
# Fixes for OpenSSL 1.1.0
# https://sourceforge.net/p/gsoap2/patches/166/
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gsoap-openssl110.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
