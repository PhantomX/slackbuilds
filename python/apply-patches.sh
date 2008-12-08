  
SB_PATCHDIR=${CWD}/patches

# From Gentoo
for patches in 02_all_db4.patch 10_all_cflags.patch 12_all_distutils-rpath-gcc.patch \
  15_all_dbm_default_gdbm_compat.patch 21_all_ctypes-execstack.patch \
  22_all_internal-expat.patch ;do
  patch -p0 -i ${SVER}/${patches} || exit 1
done

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
