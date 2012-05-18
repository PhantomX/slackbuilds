
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.1.8-swap-colors-with-poppler-0.18.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-glib-2.31.patch

set +e +o pipefail
