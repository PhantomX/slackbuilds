
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.5.1-unusedvar.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.5.2-glib-2.31.patch

set +e +o pipefail
