
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Data files should be installed with timestamps preserved
zcat ${SB_PATCHDIR}/llvm-2.6-timestamp.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/llvm-3.0-link_llvmgold_to_lto.patch

set +e +o pipefail
