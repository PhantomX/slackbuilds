
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.dpatch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.15.7-r5968.patch

set +e +o pipefail
