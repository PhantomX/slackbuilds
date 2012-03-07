
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Some fonts get chopped with Qt 4.8, http://bugs.kde.org/280896
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.8.0-kdebug280896.patch

set +e +o pipefail
