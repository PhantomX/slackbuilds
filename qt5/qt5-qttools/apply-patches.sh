
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/qttools-opensource-src-5.3.2-system-clucene.patch
# help lrelease/lupdate use/prefer qmake-qt5
# https://bugzilla.redhat.com/show_bug.cgi?id=1009893
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/qttools-opensource-src-5.5.0-qmake-qt5.patch

set +e +o pipefail
