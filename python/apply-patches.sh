
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}.readline.set_pre_input_hook.diff.gz | patch -p1 --verbose

if [ "${ARCH}" = "x86_64" ]; then
  # Install to lib64 instead of lib:
  zcat ${SB_PATCHDIR}/${NAME}.x86_64.diff.gz |  patch -p1 --verbose
  # Python must report /usr/lib64/python2.6/site-packages as python_lib_dir:
  zcat ${SB_PATCHDIR}/${NAME}.pure64.diff.gz |  patch -p1 --verbose
fi

# From Gentoo
for patches in 05_all_verbose_building_of_extensions.patch 06_all_dbm_automagic.patch \
  07_all_internal_expat.patch 08_all_non-zero_exit_status_on_failure.patch \
  09_all_use_external_libffi.patch 10_all_freebsd_linking.patch 21_all_distutils_c++.patch \
  22_all_turkish_locale.patch \
  ;do
  patch -p0 --backup --verbose -i ${PVER}/${patches}
done

# From Fedora
#zcat ${SB_PATCHDIR}/${NAME}-2.6-config.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.6-canonicalize.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.5-cflags.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-plural-fix.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-sqlite-encoding.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-socketmodule-constants.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-socketmodule-constants2.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.6-rpath.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/python-2.6.4-distutils-rpath.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/python-2.6-distutils_rpm.patch.gz | patch -p1 -E --backup --verbose

# with the "configure" part removed; appears to be identical to the version committed to 2.7
zcat ${SB_PATCHDIR}/disable-pymalloc-on-valgrind-py26.patch.gz | patch -p0 -E --backup --verbose

# Upstream patch to compile against db-4.8
# http://bugs.python.org/issue6949
# Based on http://svn.python.org/view?view=rev&revision=78974
patch -p0 -E --backup -z .db48 --verbose -i ${SB_PATCHDIR}/python-2.6.5-db48.patch

zcat ${SB_PATCHDIR}/python-2.3.4-lib64-regex.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-2.6-ctypes-noexecmem.patch
zcat ${SB_PATCHDIR}/python-2.6.4-no-static-lib.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
