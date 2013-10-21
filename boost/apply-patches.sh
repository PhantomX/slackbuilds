
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-version-override.patch
sed "s/__SONAME__/${SONAMEVER}/" ${SB_PATCHDIR}/boost-gcc-soname.patch | patch -p0 -E --backup --verbose
# https://svn.boost.org/trac/boost/ticket/6150
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.50.0-fix-non-utf8-files.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-add-bjam-man-page.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=781859
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.53.0-attribute.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.50.0-pool.patch

# https://bugzilla.redhat.com/show_bug.cgi?id=977098
# https://svn.boost.org/trac/boost/ticket/8731
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-__GLIBC_HAVE_LONG_LONG.patch

# Upstream patches posted as release notes:
# http://www.boost.org/users/history/version_1_54_0.html
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/001-coroutine.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/002-date-time.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/003-log.patch

# https://svn.boost.org/trac/boost/ticket/8826
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-context-execstack.patch

# https://svn.boost.org/trac/boost/ticket/8844
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-bind-static_assert.patch

# https://svn.boost.org/trac/boost/ticket/8847
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-concept-unused_typedef.patch

# https://svn.boost.org/trac/boost/ticket/5637
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-mpl-print.patch

# https://svn.boost.org/trac/boost/ticket/8859
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-static_warning-unused_typedef.patch

# https://svn.boost.org/trac/boost/ticket/8855
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-math-unused_typedef.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-math-unused_typedef-2.patch

# https://svn.boost.org/trac/boost/ticket/8853
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-tuple-unused_typedef.patch

# https://svn.boost.org/trac/boost/ticket/8854
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-random-unused_typedef.patch

# https://svn.boost.org/trac/boost/ticket/8856
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-date_time-unused_typedef.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-date_time-unused_typedef-2.patch

# https://svn.boost.org/trac/boost/ticket/8870
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-spirit-unused_typedef.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-spirit-unused_typedef-2.patch

# https://svn.boost.org/trac/boost/ticket/8871
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-numeric-unused_typedef.patch

# https://svn.boost.org/trac/boost/ticket/8872
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-multiprecision-unused_typedef.patch

# https://svn.boost.org/trac/boost/ticket/8874
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-unordered-unused_typedef.patch

# https://svn.boost.org/trac/boost/ticket/8876
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-algorithm-unused_typedef.patch

# https://svn.boost.org/trac/boost/ticket/8877
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-graph-unused_typedef.patch

# https://svn.boost.org/trac/boost/ticket/8878
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-locale-unused_typedef.patch

# https://svn.boost.org/trac/boost/ticket/8879
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-property_tree-unused_typedef.patch

# https://svn.boost.org/trac/boost/ticket/8880
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-xpressive-unused_typedef.patch

# https://svn.boost.org/trac/boost/ticket/8881
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-mpi-unused_typedef.patch

# https://svn.boost.org/trac/boost/ticket/8888
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-python-unused_typedef.patch

# https://svn.boost.org/trac/boost/ticket/8941
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-lexical_cast-int128.patch

# https://svn.boost.org/trac/boost/ticket/9038
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-pool-test_linking.patch

# https://svn.boost.org/trac/boost/ticket/9037
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-thread-cond_variable_shadow.patch

# This was already fixed upstream, so no tracking bug.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-pool-max_chunks_shadow.patch

# https://svn.boost.org/trac/boost/ticket/9041
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.54.0-thread-link_atomic.patch

# Gentoo
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.51.0-respect_python-buildid.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.51.0-support_dots_in_python-buildid.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-no_strict_aliasing_python2.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-disable_libboost_python3.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-python_linking.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/boost-1.48.0-disable_icu_rpath.patch

set +e +o pipefail
