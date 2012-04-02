
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p3 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.8.1-pa-side-channels.patch

set +e +o pipefail
