
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-configure.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-gcc-soname.patch.gz |sed "s/__SONAME__/${SONAMEVER}/" | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-run-tests.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-function_template.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-unneccessary_iostreams.patch.gz | patch -p0 -E --backup --verbose || exit 1

# Gentoo patches
zcat ${SB_PATCHDIR}/${NAME}-1.35.0-fix_mpi_installation.patch.gz | patch -p1 -E --backup --verbose || exit 1
