
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
## upstreamable patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/qt-mobility-opensource-src-1.2.0-translationsdir.patch
# add pkgconfig for linux-* platforms too
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/qt-mobility-opensource-src-1.2.0-pkgconfig.patch
# gcc 4.7, missing unistd.h for getppid
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/qt-mobility-opensource-src-1.2.0-include-unistdh.patch
if [ "${SB_PA}" == "YES" ] ;then
  # dso
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/qt-mobility-opensource-src-1.1.0-pulseaudio-lib.patch
fi

set +e +o pipefail
