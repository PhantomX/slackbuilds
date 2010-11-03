
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .db51 --verbose -i ${SB_PATCHDIR}/libqxt-db51.patch
# From upstream trunk. To support mod4 in qxtglobalshortcut
# http://dev.libqxt.org/libqxt/changeset/1d7ab756c1e8
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libqxt-meta-modifier.patch
# To support multimedia keys when using clementine
# Patch sent to upstream. They want to reimplement it more cleanly.
# We will use this patch until upstream reimplements it.
# http://dev.libqxt.org/libqxt/issue/75
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libqxt-media-keys.patch

set +e +o pipefail
