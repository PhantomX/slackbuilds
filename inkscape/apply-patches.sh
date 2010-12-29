
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.48.0-types.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.48.0-poppler.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.48.0-libwpd.patch

set +e +o pipefail
