
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Data files should be installed with timestamps preserved
zcat ${SB_PATCHDIR}/llvm-2.6-timestamp.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup --verbose -d tools/clang -i ${SB_PATCHDIR}/cindexer-clang-path.patch
sed -e "/getDriver/s|/lib/llvm/|/lib${LIBDIRSUFFIX}/${NAME}/|g" ${SB_PATCHDIR}/clang-3.1-fix-libprofile_rt.a-location.patch | patch -p1 -E --backup --verbose -d tools/clang

set +e +o pipefail
