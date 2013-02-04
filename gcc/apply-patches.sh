
set -e -o pipefail

# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

# From Fedora or upstream
patch -p0 -E --backup -z .hack --verbose -i ${SB_PATCHDIR}/gcc47-hack.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc47-c++-builtin-redecl.patch
####patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc47-pr33763.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc47-rh330771.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc47-libgomp-omp_h-multilib.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc47-libtool-no-rpath.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc47-pr38757.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc47-no-copy-dt-needed-entries.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc47-libitm-fno-exceptions.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc47-rh837630.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc47-arm-hfp-ldso.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc47-pr55137.patch

# From Gentoo
patch -p0 -E --backup -z .fortify --verbose -i ${SB_PATCHDIR}/10_all_gcc-default-fortify-source.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/15_all_gcc-libgomp-no-werror.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/40_all_gcc-4.4-libiberty.h-asprintf.patch

set +e +o pipefail
