
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/mplayer2-config.patch
# http://svnweb.freebsd.org/ports/head/multimedia/mplayer/files
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/mplayer-PrintGifError.patch

set +e +o pipefail
