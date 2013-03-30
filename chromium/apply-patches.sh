
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
[ "${SB_FFMPEG}" = "YES" ] && patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-system-ffmpeg-r4.patch
# Fix build issue with smhasher, gentoo bug #459126 .
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-smhasher-r0.patch
# Fix build without pnacl, to be upstreamed.
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-pnacl-r0.patch

set +e +o pipefail
