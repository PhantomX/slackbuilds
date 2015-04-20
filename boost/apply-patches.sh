
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-version-override.patch
sed "s/__SONAME__/${SONAMEVER}/" ${SB_PATCHDIR}/boost-gcc-soname.patch | patch -p0 -E --backup --verbose
# https://svn.boost.org/trac/boost/ticket/6150
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.50.0-fix-non-utf8-files.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-add-bjam-man-page.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.50.0-pool.patch

# https://svn.boost.org/trac/boost/ticket/5637
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.57.0-mpl-print.patch

# https://svn.boost.org/trac/boost/ticket/8870
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.57.0-spirit-unused_typedef.patch

# https://svn.boost.org/trac/boost/ticket/8878
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-locale-unused_typedef.patch

# https://svn.boost.org/trac/boost/ticket/8888
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-python-unused_typedef.patch

# https://svn.boost.org/trac/boost/ticket/9038
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-pool-test_linking.patch

# This was already fixed upstream, so no tracking bug.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-pool-max_chunks_shadow.patch

# https://bugzilla.redhat.com/show_bug.cgi?id=1102667
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.57.0-python-libpython_dep.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.57.0-python-abi_letters.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.55.0-python-test-PyImport_AppendInittab.patch

# https://bugzilla.redhat.com/show_bug.cgi?id=1190039
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.57.0-build-optflags.patch

# https://svn.boost.org/trac/boost/ticket/10510
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.57.0-uuid-comparison.patch

# https://bugzilla.redhat.com/show_bug.cgi?id=1192002
# https://svn.boost.org/trac/boost/ticket/11044
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.57.0-move-is_class.patch

# Gentoo
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.51.0-respect_python-buildid.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.51.0-support_dots_in_python-buildid.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-no_strict_aliasing_python2.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-disable_libboost_python3.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-disable_icu_rpath.patch

patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Add-missing-include-to-signals2-trackable.hpp.patch

set +e +o pipefail
