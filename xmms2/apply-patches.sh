
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

# Set default output to pulse
[ "${SB_PA}" = "YES" ] && patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xmms2-0.8-pulse-output-default.patch
# More sane versioning
patch -p1 -E --backup -z .versionsanity --verbose -i ${SB_PATCHDIR}/xmms2-0.8-moresaneversioning.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/xmms2-0.8-dso.patch

### Upstream
patch -p0 -E --backup -z .ffmpeg --verbose -i ${SB_PATCHDIR}/xmms2-0.8-ffmpeg.patch

### Gentoo
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xmms2-0.8-cython-0.19.1.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xmms2-0.8-memset.patch

set +e +o pipefail
