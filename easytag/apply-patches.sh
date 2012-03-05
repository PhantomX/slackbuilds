
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 --backup -z .vorbis-del --verbose -i ${SB_PATCHDIR}/${NAME}-2.1.7-vorbis-delimiter.patch
patch -p1 --backup -z .flac-del --verbose -i ${SB_PATCHDIR}/${NAME}-2.1.7-flac-delimiter.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.1.6-flac-picture.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.1.6-load-from-txt.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.1.6-defaults-675421.patch

set +e +o pipefail
