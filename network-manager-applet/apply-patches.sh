
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nm-applet-no-notifications.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nm-applet-wifi-dialog-ui-fixes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/applet-ignore-deprecated.patch

set +e +o pipefail
