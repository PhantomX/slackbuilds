
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-configure.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-gcc-soname.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-run-tests.patch.gz | patch -p0 -E --backup --verbose || exit 1

# Gentoo patches
zcat ${SB_PATCHDIR}/01_all_1.35.0-gcc-4.3-fixes-pulled_from_trunk.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/02_all_1.35.0-0001-serialization-gcc-4.3-compile-fixes.bug-1616-included.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/03_all_1.35.0-0001-spirit-gcc-4.3-fixes.bug-1617-not_included.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/04_all_1.35.0-0001-mpl-g-4.3-fix.bug-1528-not-included.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/05_all_1.35.0-0001-date_time-gcc-4.3-fix.bug-1615-not_included.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/06_all_1.35.0-0002-serialisation-utility-include.bug-1822-not_included.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/07_all_1.35.0-fix_mpi_installation.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/08_all_1.35.0-use_shared_expat.patch.gz | patch -p1 -E --backup --verbose || exit 1
