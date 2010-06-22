
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .dso --verbose -i ${SB_PATCHDIR}/${NAME}-libs.patch

set +e +o pipefail
