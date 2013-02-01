
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/webkit-1.3.10-nspluginwrapper.patch
# workarounds for non-JIT arches
# https://bugs.webkit.org/show_bug.cgi?id=104270
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/webkit-1.11.2-yarr.patch
# https://bugs.webkit.org/show_bug.cgi?id=105295
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/webkit-1.11.2-includes.patch
# https://bugs.webkit.org/show_bug.cgi?id=103128
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/webkit-1.11.2-Double2Ints.patch
# https://bugs.webkit.org/show_bug.cgi?id=107261
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/webkitgtk-1.11.4-AccessibilityTableCell-crash.patch
# https://bugs.webkit.org/show_bug.cgi?id=108032
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/webkitgtk-1.11.4-icu-cppflags.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
