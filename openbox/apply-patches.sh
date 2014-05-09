
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.5.0-xdg.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.5.2-pkgconfig.patch

set +e +o pipefail
