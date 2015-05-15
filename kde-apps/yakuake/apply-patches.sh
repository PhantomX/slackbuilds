
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Adjust-for-next-dev-cycle.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-Add-an-option-for-keeping-the-window-open-after-the-.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-Fix-the-small-typo-and-thus-the-warning.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0021-Change-default-to-appear-on-the-screen-the-pointer-i.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0022-Correctly-catch-offscreen-panels-when-building-the-e.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0023-The-F12-shortcut-is-reserved-on-Windows.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0033-Add-AppStream-metadata.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0041-Fixes-incorrect-Yakuake-height-handling-on-dualhead-.patch

set +e +o pipefail
