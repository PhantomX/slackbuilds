
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://github.com/clementine-player/Clementine/issues/4217
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-sha2.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-udisks-headers.patch

set +e +o pipefail
