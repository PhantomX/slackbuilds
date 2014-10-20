
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}.readline.set_pre_input_hook.diff.gz | patch -p1 --verbose

# From Gentoo
for patches in \
  04_all_non-zero_exit_status_on_failure.patch \
  05_all_loadable_sqlite_extensions.patch \
  06_all_regenerate_platform-specific_modules.patch \
  21_all_distutils_c++.patch \
  62_all_xml.use_pyxml.patch \
  ;do
  patch -p0 --backup --verbose -i patches/${patches}
done

if [ "${ARCH}" = "x86_64" ]; then
  # Install to lib64 instead of lib:
  patch -p1 -E --backup -z .lib64 --verbose -i ${SB_PATCHDIR}/python-2.7.3-lib64-slk.patch
  patch -p1 -E --backup -z .lib64 --verbose -i ${SB_PATCHDIR}/python-2.7-lib64-sysconfig.patch
  # Python must report /usr/lib64/python2.6/site-packages as python_lib_dir:
  zcat ${SB_PATCHDIR}/${NAME}.pure64.diff.gz |  patch -p1 --verbose
fi

# From Fedora
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-2.7rc1-config.patch
zcat ${SB_PATCHDIR}/${NAME}-2.5-cflags.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-plural-fix.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5.1-sqlite-encoding.patch
# Add various constants to the socketmodule:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-2.7rc1-socketmodule-constants.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-2.7rc1-socketmodule-constants2.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.6-rpath.patch
zcat ${SB_PATCHDIR}/python-2.6.4-distutils-rpath.patch.gz | patch -p1 -E --backup --verbose

sed -i -e 's|/usr/include/db4|/usr/include/db5|g' setup.py

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00101-lib64-regex.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00111-no-static-lib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00113-more-configuration-flags.patch
# Add flags for statvfs.f_flag to the constant list in posixmodule (i.e. "os")
# (rhbz:553020); partially upstream as http://bugs.python.org/issue7647
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00114-statvfs-f_flag-constants.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00121-add-Modules-to-build-path.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00125-less-verbose-COUNT_ALLOCS.patch

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
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00166-fix-fake-repr-in-gdb-hooks.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00169-avoid-implicit-usage-of-md5-in-multiprocessing.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00184-ctypes-should-build-with-libffi-multilib-wrapper.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00185-urllib2-honors-noproxy-for-ftp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00187-add-RPATH-to-pyexpat.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00189-gdb-py-bt-dont-raise-exception-from-eval.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00190-get_python_version.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00196-ssl-backport.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/00197-unicode_fromformat.patch

#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/05000-autotool-intermediates.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
