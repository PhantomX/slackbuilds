
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/webkit-1.3.10-nspluginwrapper.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/webkitgtk-2.4.1-cloop_fix.patch
# https://bugs.webkit.org/show_bug.cgi?id=141381
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/webkitgtk-2.4.8-gmutexlocker.patch
# https://bugs.webkit.org/show_bug.cgi?id=142074
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/webkitgtk-2.4.8-user-agent.patch
[ "${ARCH}" = "s390" ] && patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/webkitgtk-2.4.1-cloop_fix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/webkitgtk-fix-build.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
