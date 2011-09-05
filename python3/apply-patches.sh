
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

# From Gentoo
for patches in \
  05_all_verbose_building_of_extensions.patch \
  06_all_non-zero_exit_status_on_failure.patch \
  21_all_distutils_c++.patch \
  ;do
  patch -p0 --backup --verbose -i ${PDIR}/${patches}
done

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Python-3.1.1-rpath.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-3.2b2-remove-mimeaudio-tests.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-3.2.1-no-static-lib.patch
if [ "${ARCH}" = "x86_64" ]; then
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-3.2.1-lib64.patch
fi
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-3.1.2-more-configuration-flags.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-3.2a1-statvfs-f_flag-constants.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/less-verbose-COUNT_ALLOCS.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-3.2b2-test-weakref-COUNT_ALLOCS_fix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-3.2b2-fix-test-gc-COUNT_ALLOCS.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-3.2b2-test_sys-COUNT_ALLOCS.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-3.2.1-fix-test-subprocess-with-nonreadable-path-dir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-2.7.2-disable-tests-in-test_io.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/autotool-intermediates.patch

set +e +o pipefail
