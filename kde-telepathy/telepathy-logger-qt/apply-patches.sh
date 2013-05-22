
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.4.0-pkgconfig_QtGLib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.6.2-version.patch

set +e +o pipefail
