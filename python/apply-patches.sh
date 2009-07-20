  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}.readline.set_pre_input_hook.diff.gz | patch -p1 --verbose || exit 1

if [ "${ARCH}" = "x86_64" ]; then
  # Install to lib64 instead of lib:
  zcat ${SB_PATCHDIR}/${NAME}.x86_64.diff.gz |  patch -p1 --verbose || exit 1
  # Python must report /usr/lib64/python2.6/site-packages as python_lib_dir:
  zcat ${SB_PATCHDIR}/${NAME}.pure64.diff.gz |  patch -p1 --verbose || exit 1
fi

# From Gentoo
for patches in 02_all_db4.patch 12_all_distutils-rpath-gcc.patch \
  15_all_dbm_default_gdbm_compat.patch 21_all_ctypes-execstack.patch \
  22_all_internal-expat.patch ;do
  patch -p0 -i ${VERSION}/${patches} || exit 1
done
patch -p1 -i ${VERSION}/18_all_distutils-cxxflags.patch || exit 1

# From Fedora
#zcat ${SB_PATCHDIR}/${NAME}-2.6-config.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.6-canonicalize.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.5-cflags.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-plural-fix.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-sqlite-encoding.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-codec-ascii-tolower.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-socketmodule-constants.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.5.1-socketmodule-constants2.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.6-rpath.patch.gz | patch -p1 -E --backup --verbose || exit 1
