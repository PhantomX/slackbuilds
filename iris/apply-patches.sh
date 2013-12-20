
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Patches from Fedora
## upstreamable patches
# add pkgconfig support
# add 'make install' target
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/iris-1.0.0-install.patch
# Build shared library
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/iris-1.0.0-sharedlib.patch
# install jdns
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/iris-1.0.0-jdns_install.patch

set +e +o pipefail
