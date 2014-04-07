
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://github.com/clementine-player/Clementine/issues/4217
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-sha2.patch
# https://github.com/clementine-player/Clementine/commit/3df3a5b6
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-header.patch

set +e +o pipefail
