
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# fix gcc-4.7.0 build https://bugs.kde.org/show_bug.cgi?id=290642#c3
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.0-gcc-4.7.0.patch

# fix build against boost-1.48 https://bugs.kde.org/show_bug.cgi?id=287772#c22
patch -p1 -E --backup --verbose -d core -i ${SB_PATCHDIR}/${NAME}-2.5.0-boost-1.48.patch

## upstreamable patches
# move dngconverter icons oxygen->hicolor so visible outside of kde
mv extra/kipi-plugins/dngconverter/icons/oxygen \
  extra/kipi-plugins/dngconverter/icons/hicolor
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.4.1-dngconverter_hicolor_icons.patch

## upstream patches
# http://commits.kde.org/digikam/25cc9c9876a5233bd630105d0110319892d4e18c
patch -p1 -E --backup --verbose -d core -i ${SB_PATCHDIR}/${NAME}-2.5.0-libkipi-1.4.0.patch

set +e +o pipefail
