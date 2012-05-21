
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# default to using phonon (instead of mplayer)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.11.0a-kmplayerrc_phonon_default.patch

set +e +o pipefail
