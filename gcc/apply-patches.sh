
set -e -o pipefail

# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .hash-style --verbose -i ${SB_PATCHDIR}/gcc46-hash-style-both.patch

# From Fedora
patch -p0 -E --backup -z .hack --verbose -i ${SB_PATCHDIR}/gcc46-hack.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc46-c++-builtin-redecl.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc46-pr33763.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc46-rh330771.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc46-libgomp-omp_h-multilib.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc46-libtool-no-rpath.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc46-pr38757.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc46-no-add-needed.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc46-pr47858.patch

# From Gentoo
patch -p0 -E --backup -z .fortify --verbose -i ${SB_PATCHDIR}/10_all_gcc-default-fortify-source.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/15_all_gcc-libgomp-no-werror.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/40_all_gcc-4.4-libiberty.h-asprintf.patch

set +e +o pipefail
