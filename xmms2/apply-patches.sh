
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

# Set default output to pulse
[ "${SB_PA}" = "YES" ] && patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xmms2-0.8-pulse-output-default.patch
# More sane versioning
patch -p1 -E --backup -z .versionsanity --verbose -i ${SB_PATCHDIR}/xmms2-0.8-moresaneversioning.patch

### Gentoo
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xmms2-0.8-ffmpeg-0.11.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xmms2-0.8-libav-9-p2.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xmms2-0.8-libav-9.patch

set +e +o pipefail
