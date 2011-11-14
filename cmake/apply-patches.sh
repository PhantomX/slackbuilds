
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Link against the shared Python library rather than the static one
patch -p1 -E --backup -z .pylibs --verbose -i ${SB_PATCHDIR}/${NAME}-2.8.4-FindPythonLibs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.8.1-libform.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.8.3-ruby_libname.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.8.6-FindBLAS.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.8.6-FindLAPACK-2.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.8.6-CodeBlocks.patch
zcat ${SB_PATCHDIR}/${NAME}-2.8.0-kde3-include.patch.gz | patch -p0 -E --backup --verbose
# Patch to find DCMTK in Fedora (bug #720140)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-dcmtk.patch

set +e +o pipefail
