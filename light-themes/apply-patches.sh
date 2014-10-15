
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .orig --verbose -i ${SB_PATCHDIR}/${NAME}-13.04-cursor.patch

set +e +o pipefail
