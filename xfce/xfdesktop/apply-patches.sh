
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
if [ "${SB_SLKART}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/xfdesktop-4.5.92-backdrop-image.patch.gz | patch -p1 --verbose
fi
zcat ${SB_PATCHDIR}/xfdesktop-4.5.92-desktop-menu-icon.patch.gz | patch -p1 --verbose
zcat ${SB_PATCHDIR}/xfdesktop-4.6.1-menu.patch.gz | patch -p1 --verbose
# http://git.xfce.org/xfce/xfdesktop/commit/?id=c2de873891d8ce8c3be1399c6110ebfda489151b
patch -p1 --verbose -i ${SB_PATCHDIR}/xfdesktop-4.6.1-education-menu-icon.patch
# Upstream bug: http://bugzilla.xfce.org/show_bug.cgi?id=6235
patch -p1 --verbose -i ${SB_PATCHDIR}/xfdesktop-4.6.1-dsofix.patch

set +e +o pipefail
