  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}.readline.set_pre_input_hook.diff.gz | patch -p1 --verbose || exit 1

if [ "${ARCH}" = "x86_64" ]; then
  # Install to lib64 instead of lib:
  zcat ${SB_PATCHDIR}/${NAME}.x86_64.diff.gz |  patch -p1 --verbose || exit 1
  # Python must report /usr/lib64/python2.6/site-packages as python_lib_dir:
  zcat ${SB_PATCHDIR}/${NAME}.pure64.diff.gz |  patch -p1 --verbose || exit 1
fi

# From Gentoo
for patches in 01_all_static_library_location.patch 06_all_dbm_automagic.patch \
  07_all_ctypes_execstack.patch 08_all_internal_expat.patch \
  09_all_non-zero_exit_status_on_failure.patch 10_all_use_external_libffi.patch \
  11_all_disable_multiprocessing_with_disabled_threads.patch 21_all_distutils_cxxflags.patch \
  22_all_distutils_rpath_gcc.patch 23_all_turkish_locale.patch \
  ;do
  patch -p0 -i ${VERSION}/${patches} || exit 1
done

# From Fedora
#zcat ${SB_PATCHDIR}/${NAME}-2.6-config.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.6-canonicalize.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.5-cflags.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-plural-fix.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-sqlite-encoding.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-socketmodule-constants.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-socketmodule-constants2.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.6-rpath.patch.gz | patch -p1 -E --backup --verbose || exit 1
