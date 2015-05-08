
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-3.4.1-pkgconfig.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gwen-gcc47.patch

### Arch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gnutls.patch

set +e +o pipefail
