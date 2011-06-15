
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/PulsePatch.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/no_hide_applet.diff
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/fix_on_off_loop.diff

# Use blueman-open, a modified version of this, to browse obexfs shares:
# http://www.kde-apps.org/content/show.php/kde4+bluetooth+files+open?content=108869
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/blueman-use_blueman-open_for_obexfs.diff

set +e +o pipefail
