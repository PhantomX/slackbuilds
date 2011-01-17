
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Link against the shared Python library rather than the static one
patch -p0 -E --backup -z .pylibs --verbose -i ${SB_PATCHDIR}/${NAME}-FindPythonLibs.patch
patch -p0 -E --backup -z .pyinterp --verbose -i ${SB_PATCHDIR}/${NAME}-FindPythonInterp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.8.1-FindBoost.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.8.1-libform.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.8.3-FindLibArchive.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.8.3-ruby_libname.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.8.3-buffer_overflow.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.8.3-fix_assembler_test.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.8.3-fix-asm-support.patch
zcat ${SB_PATCHDIR}/${NAME}-2.8.0-kde3-include.patch.gz | patch -p0 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.8.3-qt4.patch

set +e +o pipefail
