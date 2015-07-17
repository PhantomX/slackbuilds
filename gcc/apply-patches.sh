
set -e -o pipefail

# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Prevents build error with 10_all_default-fortify-source.patch below
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-libitm-no-fortify.patch

# From Fedora or upstream
patch -p0 -E --backup -z .hack --verbose -i ${SB_PATCHDIR}/gcc5-hack.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-rh330771.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-libgomp-omp_h-multilib.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-libtool-no-rpath.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-libstdc++-docs.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-isl-dl.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-no-copy-dt-needed-entries.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-libgo-p224.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-pr65689.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-pr66748.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-pr66896.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-pr66725.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc.git-303a4dcbfb01788efe8edf70a67b6af2a50d0959.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-pr56520.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-pr66545.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-pr66864.patch


# From Gentoo
patch -p1 -E --backup -z .fortify --verbose -i ${SB_PATCHDIR}/10_all_default-fortify-source.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/50_all_libiberty-asprintf.patch

set +e +o pipefail
