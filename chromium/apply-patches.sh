
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Gentoo
[ "${SB_FFMPEG}" = "YES" ] && patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-system-ffmpeg-r5.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-system-harfbuzz-r0.patch

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-nss.patch

set +e +o pipefail
