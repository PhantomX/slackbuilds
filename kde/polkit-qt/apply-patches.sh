
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.95.1-install-cmake-find.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Post-tagging-version-bump.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-pedantic.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-no-need-to-use-REQUIRED-for-pkg-config-since-the-res.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-avoid-crash-when-ConsoleKit-is-unavailable.patch
# http://bugs.kde.org/258916
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-BUG-258916.patch

set +e +o pipefail
