
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-no-xtest.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.11.0a-kmplayerrc_phonon_default.patch

set +e +o pipefail
