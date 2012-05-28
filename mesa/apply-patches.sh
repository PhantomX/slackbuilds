
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mesa-7.10-llvmcore.patch
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mesa-7.10-swrastg.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mesa-8.0.3-llvm-3.1-fixes.patch

set +e +o pipefail
