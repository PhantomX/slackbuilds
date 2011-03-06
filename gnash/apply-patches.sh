
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/gnash-0.8.3-boost-dynamic-link.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/gnash-0.8.3-fix-kde4-port.patch.gz | patch -p1 -E --backup --verbose
# FD_ZERO should not be called between curl_multi_fset and select
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gnash-0.8.8-libcurl721-FD_ZERO.patch
# give more time to DNS resolving so we can still connect with libcurl >= 7.21.x
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gnash-0.8.8-libcurl721-DNS-resolving.patch

set +e +o pipefail
