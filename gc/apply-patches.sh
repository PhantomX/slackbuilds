
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# To be more backward-compatible abi-wise, TODO: upstream ml reference
## upstreamable patches
zcat ${SB_PATCHDIR}/gc-7.1-dup_cpp_headers.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gc-7.2alpha4-install_dups.patch

## upstream patches

set +e +o pipefail
