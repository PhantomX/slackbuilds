
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Data files should be installed with timestamps preserved
zcat ${SB_PATCHDIR}/llvm-2.6-timestamp.patch.gz | patch -p1 -E --backup --verbose
# rename alignof -> alignOf for C++0x support
# http://llvm.org/bugs/show_bug.cgi?id=8423
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/llvm-2.8-alignOf.patch
( cd tools/clang
  patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/clang-2.8-alignOf.patch
)

set +e +o pipefail
