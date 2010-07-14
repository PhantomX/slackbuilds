
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}.readline.set_pre_input_hook.diff.gz | patch -p1 --verbose

# From Gentoo
for patches in \
  00_all_branch_backports.patch \
  05_all_verbose_building_of_extensions.patch \
  06_all_dbm_automagic.patch \
  07_all_internal_expat.patch \
  08_all_non-zero_exit_status_on_failure.patch \
  09_all_use_external_libffi.patch \
  21_all_distutils_c++.patch \
  22_all_turkish_locale.patch \
  ;do
  patch -p0 --backup --verbose -i ${PDIR}/${patches}
done

if [ "${ARCH}" = "x86_64" ]; then
  # Install to lib64 instead of lib:
  patch -p1 -E --backup -z .x86_64 --verbose -i ${SB_PATCHDIR}/python.x86_64.diff
  # Python must report /usr/lib64/python2.6/site-packages as python_lib_dir:
  zcat ${SB_PATCHDIR}/${NAME}.pure64.diff.gz |  patch -p1 --verbose
fi

# From Fedora
#zcat ${SB_PATCHDIR}/${NAME}-2.6-config.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-2.6.5-canonicalize.patch
zcat ${SB_PATCHDIR}/${NAME}-2.5-cflags.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-plural-fix.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-sqlite-encoding.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-socketmodule-constants.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-socketmodule-constants2.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.6-rpath.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/python-2.6.4-distutils-rpath.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/python-2.6-distutils_rpm.patch.gz | patch -p1 -E --backup --verbose

# with the "configure" part removed; appears to be identical to the version committed to 2.7
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/disable-pymalloc-on-valgrind-py26.patch

# Upstream patch to compile against db-4.8
# http://bugs.python.org/issue6949
# Based on http://svn.python.org/view?view=rev&revision=78974
patch -p0 -E --backup -z .db48 --verbose -i ${SB_PATCHDIR}/python-2.6.5-db48.patch

zcat ${SB_PATCHDIR}/python-2.3.4-lib64-regex.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-2.6.5-ctypes-noexecmem.patch
zcat ${SB_PATCHDIR}/python-2.6.4-no-static-lib.patch.gz | patch -p1 -E --backup --verbose

# Add flags for statvfs.f_flag to the constant list in posixmodule (i.e. "os")
# (rhbz:553020); partially upstream as http://bugs.python.org/issue7647
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-2.6.5-statvfs-f_flag-constants.patch

# Make "pydoc -k" more robust in the face of broken modules
# (rhbz:461419; patch sent upstream as http://bugs.python.org/issue7425 )
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/make-pydoc-more-robust-001.patch

# Fix an incompatibility between pyexpat and the system expat-2.0.1 that led to
# a segfault running test_pyexpat.py (rhbz:583931)
# Sent upstream as http://bugs.python.org/issue9054
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/python-2.6.5-fix-expat-issue9054.patch

set +e +o pipefail
