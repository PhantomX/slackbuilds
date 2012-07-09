
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-version-override.patch
sed "s/__SONAME__/${SONAMEVER}/" ${SB_PATCHDIR}/boost-gcc-soname.patch | patch -p0 -E --backup --verbose
# The patch may break c++03, and there is therefore no plan yet to include
# it upstream: https://svn.boost.org/trac/boost/ticket/4999
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-signals-erase.patch
# https://svn.boost.org/trac/boost/ticket/5731
#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-exceptions.patch
# https://svn.boost.org/trac/boost/ticket/6150
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-fix-non-utf8-files.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-add-bjam-man-page.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-pool.patch

# Gentoo
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-respect_python-buildid.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-support_dots_in_python-buildid.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-no_strict_aliasing_python2.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-disable_libboost_python3.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-python_linking.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-disable_icu_rpath.patch

set +e +o pipefail
