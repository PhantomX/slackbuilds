
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
# kill rpath
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/qt-mobility-opensource-src-1.2.2-no_rpath.patch
## upstreamable patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/qt-mobility-opensource-src-1.2.0-translationsdir.patch
# add pkgconfig for linux-* platforms too
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/qt-mobility-opensource-src-1.2.2-pkgconfig.patch
# fix ftbfs in sensors doc
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/qt-mobility-opensource-src-1.2.2-sensors_ftbfs.patch
if [ "${SB_PA}" == "YES" ] ;then
  # dso
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/qt-mobility-opensource-src-1.1.0-pulseaudio-lib.patch
fi

set +e +o pipefail
