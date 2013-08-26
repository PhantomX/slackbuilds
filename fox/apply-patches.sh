
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fox-1.6.43-multilib.patch
### Fedora
# Change Adie.stx path
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fox-1.6.49-adie-syspath.patch
# Fix libCHART.so linkage (already fixed in 1.7.x branch)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fox-1.6.49-libCHART-linkage.patch

set +e +o pipefail
