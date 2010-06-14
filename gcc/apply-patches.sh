
set -e -o pipefail

# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/gcc44-hash-style-both.patch.gz | patch -p0
zcat ${SB_PATCHDIR}/gcc44-libtool-no-rpath.patch.gz | patch -p0 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc44-libgomp-omp_h-multilib.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc44-no-add-needed-slk.patch

# From Gentoo
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/02_all_gcc45-pr42347.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/10_all_gcc-default-fortify-source.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/15_all_gcc-libgomp-no-werror.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/40_all_gcc-4.4-libiberty.h-asprintf.patch

# Upstream
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc-4.5.0-r160561.patch

set +e +o pipefail
