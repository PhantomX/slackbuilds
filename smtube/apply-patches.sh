
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Add mplayer2, mpv and quiet output (spams xsession-errors)
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-mplayer-family.patch

set +e +o pipefail
