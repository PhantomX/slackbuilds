
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

# From Gentoo
for patches in \
  04_all_non-zero_exit_status_on_failure.patch \
  05_all_regenerate_platform-specific_modules.patch \
  21_all_distutils_c++.patch \
  ;do
  patch -p0 --backup --verbose -i ${PVER}/${patches}
done

### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Python-3.1.1-rpath.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00003-remove-mimeaudio-tests.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00111-no-static-lib.patch
if [ "${ARCH}" = "x86_64" ]; then
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-3.3.0b1-lib64.patch
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00104-lib64-fix-for-test_install.patch
fi
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00113-more-configuration-flags.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00114-statvfs-f_flag-constants.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00125-less-verbose-COUNT_ALLOCS.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-3.2.1-fix-test-subprocess-with-nonreadable-path-dir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00131-disable-tests-in-test_io.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00134-fix-COUNT_ALLOCS-failure-in-test_sys.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00135-fix-test-within-test_weakref-in-debug-build.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00141-fix-test_gc_with_COUNT_ALLOCS.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/00153-fix-test_gdb-noise.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00156-gdb-autoload-safepath.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00157-uid-gid-overflows.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00177-platform-unicode.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00178-dont-duplicate-flags-in-sysconfig.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00179-dont-raise-error-on-gdb-corrupted-frames-in-backtrace.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00183-cve-2013-2099-fix-ssl-match_hostname-dos.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00184-ctypes-should-build-with-libffi-multilib-wrapper.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00185-CVE-2013-4238-hostname-check-bypass-in-SSL-module.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
