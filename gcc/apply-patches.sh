
set -e -o pipefail

# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# http://gcc.gnu.org/bugzilla/show_bug.cgi?id=56754

# From Fedora or upstream
patch -p0 -E --backup -z .hack --verbose -i ${SB_PATCHDIR}/gcc48-hack.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc48-rh330771.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc48-libgomp-omp_h-multilib.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc48-libtool-no-rpath.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc48-cloog-dl.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc48-cloog-dl2.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc48-pr38757.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc48-libstdc++-docs.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc48-no-copy-dt-needed-entries.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc48-pr56930.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc48-pr57319.patch

# From Gentoo
patch -p0 -E --backup -z .fortify --verbose -i ${SB_PATCHDIR}/10_all_gcc-default-fortify-source.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/15_all_gcc-libgomp-no-werror.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/40_all_gcc-4.4-libiberty.h-asprintf.patch


set +e +o pipefail
