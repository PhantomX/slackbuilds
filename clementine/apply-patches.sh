
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .pofix --verbose -i ${SB_PATCHDIR}/${NAME}-0.4.2-pofix.patch

set +e +o pipefail
