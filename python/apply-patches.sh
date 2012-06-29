
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}.readline.set_pre_input_hook.diff.gz | patch -p1 --verbose

# From Gentoo
for patches in \
  05_all_verbose_building_of_extensions.patch \
  06_all_non-zero_exit_status_on_failure.patch \
  21_all_distutils_c++.patch \
  ;do
  patch -p0 --backup --verbose -i ${PVER}/${patches}
done

if [ "${ARCH}" = "x86_64" ]; then
  # Install to lib64 instead of lib:
  patch -p1 -E --backup -z .lib64 --verbose -i ${SB_PATCHDIR}/python-2.7rc1-lib64-slk.patch
  patch -p1 -E --backup -z .lib64 --verbose -i ${SB_PATCHDIR}/python-2.7-lib64-sysconfig.patch
  # Python must report /usr/lib64/python2.6/site-packages as python_lib_dir:
  zcat ${SB_PATCHDIR}/${NAME}.pure64.diff.gz |  patch -p1 --verbose
fi

# From Fedora
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-2.7rc1-config.patch
zcat ${SB_PATCHDIR}/${NAME}-2.5-cflags.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-plural-fix.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-sqlite-encoding.patch.gz | patch -p1 -E --backup --verbose
# Add various constants to the socketmodule:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-2.7rc1-socketmodule-constants.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-2.7rc1-socketmodule-constants2.patch
zcat ${SB_PATCHDIR}/${NAME}-2.6-rpath.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/python-2.6.4-distutils-rpath.patch.gz | patch -p1 -E --backup --verbose

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-2.7-db51.diff
sed -i -e 's|/usr/include/db4|/usr/include/db51|g' setup.py

zcat ${SB_PATCHDIR}/python-2.3.4-lib64-regex.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00111-no-static-lib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00113-more-configuration-flags.patch
# Add flags for statvfs.f_flag to the constant list in posixmodule (i.e. "os")
# (rhbz:553020); partially upstream as http://bugs.python.org/issue7647
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00114-statvfs-f_flag-constants.patch

patch -p0 -R -E --backup --verbose -i ${SB_PATCHDIR}/python-2.7rc2-r79310.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00125-less-verbose-COUNT_ALLOCS.patch

# Fix dbm module on big-endian 64-bit
# Sent upstream as http://bugs.python.org/issue9687 (rhbz#626756)
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/fix-dbm_contains-on-64bit-bigendian.patch
# Fix test_structmember on big-endian 64-bit
# Sent upstream as http://bugs.python.org/issue9960
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-test_structmember-on-64bit-bigendian.patch
# 2.7.1 (in r84230) added a test to test_abc which fails if python is
# configured with COUNT_ALLOCS, which is the case for our debug build
# (the COUNT_ALLOCS instrumentation keeps "C" alive).
# Not yet sent upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00141-fix-test_gc_with_COUNT_ALLOCS.patch

# Backport of part of fix for http://bugs.python.org/issue12326
####patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00145-force-sys-platform-to-be-linux2.patch

# Add a sys._debugmallocstats() function
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00147-add-debug-malloc-stats.patch

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/00153-fix-test_gdb-noise.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00156-gdb-autoload-safepath.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00157-uid-gid-overflows.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/05000-autotool-intermediates.patch

set +e +o pipefail
