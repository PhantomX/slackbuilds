
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
rm -rf js/src/editline -rf
rm -rf js/src/ctypes/libffi
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/js17-build-fixes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/js17-jsval.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mozbug746112-no-decommit-on-large-pages.patch
# http://patchwork.openembedded.org/patch/97315/
patch -p0 -E --backup --verbose -d js -i ${SB_PATCHDIR}/fix_milestone_compile_issue.patch

set +e +o pipefail
