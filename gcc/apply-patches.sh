
set -e -o pipefail

# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Prevents build error with 10_all_default-fortify-source.patch below
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc6-libitm-no-fortify.patch

# From Fedora or upstream
patch -p0 -E --backup -z .hack --verbose -i ${SB_PATCHDIR}/gcc6-hack.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc6-rh330771.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc6-libgomp-omp_h-multilib.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc6-libtool-no-rpath.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc6-libstdc++-docs.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc6-isl-dl.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc6-no-copy-dt-needed-entries.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc6-libgo-p224.patch

# From Gentoo
patch -p1 -E --backup -z .fortify --verbose -i ${SB_PATCHDIR}/10_all_default-fortify-source.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/11_all_default-warn-format-security.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/13_all_default-ssp-fix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/50_all_libiberty-asprintf.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/90_all_pr55930-dependency-tracking.patch

set +e +o pipefail
