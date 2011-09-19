
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -d dragonplayer -i ${SB_PATCHDIR}/${NAME}-4.7.1-dragonplayer-phonon-dvd-menu.patch

set +e +o pipefail
