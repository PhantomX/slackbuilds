
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## upstreamable patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-0.9.18-pkgconfig_llvm_libs_private.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.9.18-llvm-3.3svn.patch

set +e +o pipefail
