
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
# Don't build examples, Include qtsinglecoreapplication library in the build:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-build.diff
# The library includes a duplicate of qtlockedfile. We link to it dynamically instead:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-dont-bundle-external-libs.patch
# Additional API for building clementine
# http://bugreports.qt.nokia.com/browse/QTSOLBUG-133
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-add-api.patch
# gcc-4.7 compilation fix
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-gcc47.patch

set +e +o pipefail
