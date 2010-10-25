
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Enable optional support for gecko-mediaplayer.
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-gecko-mediaplayer-r0.patch

set +e +o pipefail
