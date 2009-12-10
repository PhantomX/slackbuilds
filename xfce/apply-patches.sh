  
SB_PATCHDIR=${CWD}/patches

if [ "${SPNAME}" = "exo" ]; then
  zcat ${SB_PATCHDIR}/exo-0.3.0-x86_64-build.patch.gz | patch -p1 --verbose || exit 1
  # http://patches.ubuntu.com/e/exo/extracted/xubuntu-default-mount-options.patch
  zcat ${SB_PATCHDIR}/exo-0.3.105-default-mount-options.patch.gz | patch -p1 --verbose || exit 1
fi

if [ "${SPNAME}" = "xfdesktop" ]; then
  echo
  if [ "${SB_SLKART}" = "YES" ] ;then
    zcat ${SB_PATCHDIR}/xfdesktop-4.5.92-backdrop-image.patch.gz | patch -p1 --verbose || exit 1
  fi
    zcat ${SB_PATCHDIR}/xfdesktop-4.5.92-desktop-menu-icon.patch.gz | patch -p1 --verbose || exit 1
    zcat ${SB_PATCHDIR}/xfdesktop-4.6.1-menu.patch.gz | patch -p1 --verbose || exit 1
fi

if [ "${SPNAME}" = "xfwm4" ]; then
  if [ "${SB_SLKART}" = "YES" ] ;then
    zcat ${SB_PATCHDIR}/xfwm4-4.6.0-clearlooks.patch.gz | patch -p1 --verbose || exit 1
  fi
  zcat ${SB_PATCHDIR}/xfwm4-4.6.1-focus.patch.gz | patch -p1 --verbose || exit 1
fi

if [ "${SPNAME}" = "libxfcegui4" ]; then
  zcat ${SB_PATCHDIR}/libxfcegui4-4.4.2-xfce-exec-use-thunar.patch.gz | patch -p1 --verbose || exit 1
fi

if [ "${SPNAME}" = "xfce-utils" ]; then
  if [ "${SB_PA}" = "YES" ] ; then
    zcat ${SB_PATCHDIR}/xfce-utils-4.4.2-pulseaudio.patch.gz | patch -p1 --verbose || exit 1
  fi
  zcat ${SB_PATCHDIR}/xfce-utils-4.4.3-xfterm4-bug.patch.gz | patch -p1 --verbose || exit 1
  zcat ${SB_PATCHDIR}/xfce-utils-4.6.1-startxfce-data-dirs.patch.gz | patch -p1 --verbose || exit 1
  zcat ${SB_PATCHDIR}/xfce-utils-4.6.1-xdgconfig.patch.gz | patch -p1 --verbose || exit 1
fi

if [ "${SPNAME}" = "xfce4-panel" ]; then
  zcat ${SB_PATCHDIR}/xfce4-panel-4.6.0-defaults.patch.gz | patch -p1 --verbose || exit 1
fi

if [ "${SPNAME}" = "xfce4-session" ]; then
  zcat ${SB_PATCHDIR}/xfce4-session-4.5.92-hide-tips.patch.gz | patch -p1 --verbose || exit 1
  # http://patches.ubuntu.com/x/xfce4-session/extracted/01_correct_shadows.patch
  zcat ${SB_PATCHDIR}/xfce4-session-4.6.1-correct-shadows.patch.gz | patch -p1 --verbose || exit 1
fi
