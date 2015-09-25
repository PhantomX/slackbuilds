
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-widget-Only-show-the-cursor-on-motion-if-moved.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vte291-command-notify.patch

set +e +o pipefail
