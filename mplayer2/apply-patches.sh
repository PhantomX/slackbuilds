
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/mplayer-1.0pre8-config.patch.gz | patch -p0 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/live-media.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-vf_lavc-fix-compilation-with-latest-libav.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-stream_ftp-fix-double-free-in-one-error-case.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0008-mixer-fix-crash-when-muted-and-audio-init-fails.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0009-fmt-conversion.h-fix-pixfmt.h-include-fixes-latest-L.patch

set +e +o pipefail
