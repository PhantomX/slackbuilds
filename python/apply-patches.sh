
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Set to test (some patches require others, so, is not 100%)
PATCH_DRYRUN=${PATCH_DRYRUN:-NO}

unset PATCH_DRYRUN_OPT PATCH_VERBOSE_OPT

[ "${PATCH_DRYRUN}" = "YES" ] && PATCH_DRYRUN_OPT="--dry-run"
[ "${PATCH_VERBOSE}" = "YES" ] && PATCH_VERBOSE_OPT="--verbose"
[ "${PATCH_SVERBOSE}" = "YES" ] && set -o xtrace

PATCHCOM="patch ${PATCH_DRYRUN_OPT} -p1 -F1 -s ${PATCH_VERBOSE_OPT}"

ApplyPatch() {
  local patch=$1
  shift
  if [ ! -f ${SB_PATCHDIR}/${patch} ]; then
    exit 1
  fi
  echo "Applying ${patch}"
  case "${patch}" in
  *.bz2) bzcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *.gz) zcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *) ${PATCHCOM} ${1+"$@"} -i "${SB_PATCHDIR}/${patch}" ;;
  esac
}

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
  patch -p1 -E --backup -z .lib64 --verbose -i ${SB_PATCHDIR}/00102-2.7.12-lib64-slk.patch
  patch -p1 -E --backup -z .lib64 --verbose -i ${SB_PATCHDIR}/python-2.7-lib64-sysconfig.patch
  # Python must report /usr/lib64/python2.6/site-packages as python_lib_dir:
  zcat ${SB_PATCHDIR}/${NAME}.pure64.diff.gz |  patch -p1 --verbose
fi

### Fedora
zcat ${SB_PATCHDIR}/${NAME}-2.5-cflags.patch.gz | patch -p1 -E --backup --verbose
ApplyPatch ${NAME}-2.5.1-plural-fix.patch
ApplyPatch ${NAME}-2.5.1-sqlite-encoding.patch
# (rhbz:307221)
ApplyPatch 00010-2.7.12-binutils-no-dep.patch
# Add various constants to the socketmodule:
ApplyPatch python-2.7rc1-socketmodule-constants.patch
ApplyPatch python-2.7rc1-socketmodule-constants2.patch
ApplyPatch ${NAME}-2.6-rpath.patch
zcat ${SB_PATCHDIR}/python-2.6.4-distutils-rpath.patch.gz | patch -p1 -E --backup --verbose

sed -i -e 's|/usr/include/db4|/usr/include/db5|g' setup.py

ApplyPatch 00111-no-static-lib-slk.patch
ApplyPatch 00113-more-configuration-flags.patch
# Add flags for statvfs.f_flag to the constant list in posixmodule (i.e. "os")
# (rhbz:553020); partially upstream as http://bugs.python.org/issue7647
ApplyPatch 00114-statvfs-f_flag-constants.patch

ApplyPatch 00121-add-Modules-to-build-path.patch

ApplyPatch 00125-less-verbose-COUNT_ALLOCS.patch

# 2.7.1 (in r84230) added a test to test_abc which fails if python is
# configured with COUNT_ALLOCS, which is the case for our debug build
# (the COUNT_ALLOCS instrumentation keeps "C" alive).
# Not yet sent upstream
ApplyPatch 00141-fix-test_gc_with_COUNT_ALLOCS.patch

# Backport of part of fix for http://bugs.python.org/issue12326
####ApplyPatch 00145-force-sys-platform-to-be-linux2.patch

# Add a sys._debugmallocstats() function
ApplyPatch 00147-add-debug-malloc-stats.patch

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/00153-fix-test_gdb-noise.patch

ApplyPatch 00156-gdb-autoload-safepath.patch
ApplyPatch 00169-avoid-implicit-usage-of-md5-in-multiprocessing.patch
ApplyPatch 00184-ctypes-should-build-with-libffi-multilib-wrapper.patch
ApplyPatch 00187-add-RPATH-to-pyexpat.patch
ApplyPatch 00189-gdb-py-bt-dont-raise-exception-from-eval.patch
ApplyPatch 00200-skip-thread-test.patch
ApplyPatch 00209-fix-test-pyexpat-failure.patch
ApplyPatch 00242-CVE-2016-1000110-httpoxy.patch
ApplyPatch 00247-port-ssl-and-hashlib-to-OpenSSL-1.1.0.patch


#ApplyPatch 05000-autotool-intermediates.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
