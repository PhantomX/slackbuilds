
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .orig --verbose -i ${SB_PATCHDIR}/${NAME}-px.patch

set +e +o pipefail
