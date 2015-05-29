
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Use blueman-open, a modified version of this, to browse obexfs shares:
# http://www.kde-apps.org/content/show.php/kde4+bluetooth+files+open?content=108869
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/blueman-use_blueman-open_for_obexfs.diff

### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Drop-browse-feature.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix_bluetoothd_path.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Rename-blueman-applet.service-to-org.blueman.Applet..patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
