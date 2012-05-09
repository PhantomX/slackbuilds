
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

# From Gentoo
for patches in \
  05_all_verbose_building_of_extensions.patch \
  06_all_non-zero_exit_status_on_failure.patch \
  21_all_distutils_c++.patch \
  ;do
  patch -p0 --backup --verbose -i ${PVER}/${patches}
done

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Python-3.1.1-rpath.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-3.2b2-remove-mimeaudio-tests.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00111-no-static-lib.patch
if [ "${ARCH}" = "x86_64" ]; then
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-3.2.3-lib64.patch
fi
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00113-more-configuration-flags.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00114-statvfs-f_flag-constants.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00125-less-verbose-COUNT_ALLOCS.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-3.2.1-fix-test-subprocess-with-nonreadable-path-dir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00131-disable-tests-in-test_io.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00134-fix-COUNT_ALLOCS-failure-in-test_sys.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00135-fix-test-within-test_weakref-in-debug-build.patch
# Add a sys._debugmallocstats() function
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00147-add-debug-malloc-stats.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/00152-fix-test-gdb-regex.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/autotool-intermediates.patch

set +e +o pipefail
