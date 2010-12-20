
set -e -o pipefail

# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/gcc44-hash-style-both.patch.gz | patch -p0 -E --backup -z .hash-style --verbose

# From Fedora
patch -p0 -E --backup -z .hack --verbose -i ${SB_PATCHDIR}/gcc45-hack.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc45-c++-builtin-redecl.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc45-pr33763.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc45-rh330771.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc45-libgomp-omp_h-multilib.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc45-libtool-no-rpath.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc45-pr38757.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc45-no-add-needed-slk.patch

# From Gentoo
patch -p0 -E --backup -z .fortify --verbose -i ${SB_PATCHDIR}/10_all_gcc-default-fortify-source.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/15_all_gcc-libgomp-no-werror.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/40_all_gcc-4.4-libiberty.h-asprintf.patch

set +e +o pipefail
