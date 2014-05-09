
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.95.1-install-cmake-find.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Sync-FindGObject.cmake-with-the-one-in-kdelibs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Normalize-connect-using-Qt-s-normalize.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-Fixed-reference-counting-of-GObjects.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-Fixed-GCancellable-handling-in-PolkitQtListener.patch

set +e +o pipefail
