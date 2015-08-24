
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/js-1.8.5-64bit-big-endian.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/js-1.8.5-secondary-jit.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/js185-destdir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/js-1.8.5-537701.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/js185-libedit.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Make-js-config.h-multiarch-compatible.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=1178141 (http://hg.mozilla.org/mozilla-central/rev/a7b220e7425a)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/js-1.8.5-array-recursion.patch
# http://patchwork.openembedded.org/patch/97315/
patch -p0 -E --backup --verbose -d js -i ${SB_PATCHDIR}/fix_milestone_compile_issue.patch

set +e +o pipefail
