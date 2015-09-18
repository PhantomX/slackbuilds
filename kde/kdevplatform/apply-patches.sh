
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# remove set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE) line
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.2.3-no-rpath.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.7.1-boost157.patch
# http://quickgit.kde.org/?p=kdevplatform.git&a=commit&h=8117ca137b45816865554d6e86b96d9e633a7e08
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-svn19.patch

set +e +o pipefail
