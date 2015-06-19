
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
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-pr65956.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-r224063.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-pr65527.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-pr66289.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-pr66450.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-pr66387.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-pr58063.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-pr66536.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-pr66429.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc5-pr66571.patch

# From Gentoo
patch -p1 -E --backup -z .fortify --verbose -i ${SB_PATCHDIR}/10_all_default-fortify-source.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/50_all_libiberty-asprintf.patch

set +e +o pipefail
