
set -e -o pipefail

# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/gcc44-hash-style-both.patch.gz | patch -p0
zcat ${SB_PATCHDIR}/gcc44-libtool-no-rpath.patch.gz | patch -p0 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc44-libgomp-omp_h-multilib.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gcc44-no-add-needed-slk.patch

set +e +o pipefail
