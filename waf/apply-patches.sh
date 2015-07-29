
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/waf-1.8.11-libdir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/waf-1.6.9-logo.patch

set +e +o pipefail
