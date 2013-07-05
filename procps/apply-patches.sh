
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Display the location from which the user is logged in by default.
# This is how previous versions of 'w' in Slackware have always
# defaulted.
zcat ${SB_PATCHDIR}/${NAME}.w.showfrom.diff.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-off-by-one-in-pmap.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-top-enable-screen-contents-preservation-at-end-of-jo.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-top-refine-some-miscellaneous-signals-interrupt-stuf.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-library-for-atexit-support-fix-fileutils-for-EPIPE.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-top-cursor-repositioning-includes-line-oriented-inpu.patch

set +e +o pipefail
