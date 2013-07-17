
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-version-override.patch
sed "s/__SONAME__/${SONAMEVER}/" ${SB_PATCHDIR}/boost-gcc-soname.patch | patch -p0 -E --backup --verbose
# https://svn.boost.org/trac/boost/ticket/6150
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.50.0-fix-non-utf8-files.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-add-bjam-man-page.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.50.0-foreach.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=781859
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.53.0-attribute.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=783660
# https://svn.boost.org/trac/boost/ticket/6459 fixed
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.50.0-long-double-1.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=784654
patch -p3 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.50.0-polygon.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.50.0-pool.patch

# Gentoo
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.51.0-respect_python-buildid.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.51.0-support_dots_in_python-buildid.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-no_strict_aliasing_python2.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-disable_libboost_python3.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-python_linking.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-disable_icu_rpath.patch

set +e +o pipefail
