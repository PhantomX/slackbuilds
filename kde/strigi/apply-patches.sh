
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

## upstream patches
( cd libstreamanalyzer
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libstreamanalyzer-0001-Fix-for-non-valid-values-in-Exif-field-ISOSpeedRatin.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libstreamanalyzer-0002-order-matters-for-systems-that-have-things-already-i.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libstreamanalyzer-0003-Fix-Krazy-issues.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libstreamanalyzer-0004-ffmpeg-Rename-mutex-to-g_mutex.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libstreamanalyzer-0005-use-rpath-only-when-needed.patch
)
( cd libstreams
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libstreams-0001-Generate-config.h-after-looking-for-dependencies.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libstreams-0002-Reduce-noise-in-analysis-tools-complain-about-resour.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libstreams-0003-Build-fix-for-gcc-4.8.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libstreams-0004-Fix-Krazy-issues.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libstreams-0005-use-rpath-only-when-needed.patch
)
patch -p1 -E --backup --verbose -d strigiclient -i ${SB_PATCHDIR}/strigiclient-0001-use-rpath-only-when-needed.patch
( cd strigidaemon
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/strigidaemon-0001-Fix-Krazy-issues.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/strigidaemon-0002-use-rpath-only-when-needed.patch
)
patch -p1 -E --backup --verbose -d strigiutils -i ${SB_PATCHDIR}/strigiutils-0001-use-rpath-only-when-needed.patch

set +e +o pipefail
