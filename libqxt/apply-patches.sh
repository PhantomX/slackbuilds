
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# To support multimedia keys when using clementine
# Patch sent to upstream. They want to reimplement it more cleanly.
# We will use this patch until upstream reimplements it.
# http://dev.libqxt.org/libqxt/issue/75
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libqxt-media-keys.patch
# Fix wrong header includes RHBZ#733222
# http://dev.libqxt.org/libqxt/issue/112/wrong-include-in-qxtnetworkh
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libqxt-header-fix.patch

set +e +o pipefail
