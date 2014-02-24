
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/LibRaw-0.6.0-pkgconfig.patch

set +e +o pipefail
