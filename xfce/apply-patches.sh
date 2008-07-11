  
SB_PATCHDIR=${CWD}/patches

if [ "${file}" = "xfdesktop-${VERSION}.tar.bz2" ]; then
  # Official patch to fix memory leak in xfdesktop:
  zcat ${SB_PATCHDIR}/xfdesktop-desktop-menu-dentry.diff.gz | patch -p1 --verbose || exit 1
  
  if [ "${SB_SLKART}" = "YES" ] ;then
    zcat ${SB_PATCHDIR}/xfdesktop-image-4.3.90.1.patch.gz | patch -p1 --verbose || exit 1
    zcat ${SB_PATCHDIR}/xfdesktop-4.4.2-show-backdrop-by-default.patch.gz | patch -p1 --verbose || exit 1
  fi
fi

if [ "${file}" = "Thunar-${THUVER}.tar.bz2" ]; then
  # Official patch from Thunar developer 
  # http://foo-projects.org/pipermail/xfce4-dev/2007-December/023857.html
  zcat ${SB_PATCHDIR}/thunar-vfs-volume-hal_missing-audio-cds-for-volman.patch.gz | patch -p0 --verbose || exit 1
  # http://bugzilla.xfce.org/show_bug.cgi?id=2983
  zcat ${SB_PATCHDIR}/thunar_xfdesktop-zombie_process-fix.diff.gz | patch -p1 --verbose || exit 1
fi
