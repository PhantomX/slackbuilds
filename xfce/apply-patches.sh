  
SB_PATCHDIR=${CWD}/patches

if [ "${BASENAME}" = "xfdesktop-${VERSION}" ]; then
  echo
  if [ "${SB_SLKART}" = "YES" ] ;then
    zcat ${SB_PATCHDIR}/xfdesktop-4.5.92-backdrop-image.patch.gz | patch -p1 --verbose || exit 1
  fi
    zcat ${SB_PATCHDIR}/xfdesktop-4.5.92-desktop-menu-icon.patch.gz | patch -p1 --verbose || exit 1
    zcat ${SB_PATCHDIR}/xfdesktop-4.6.0-wine-menu.patch.gz | patch -p1 --verbose || exit 1
fi

if [ "${BASENAME}" = "xfwm4-${VERSION}" ]; then
  if [ "${SB_SLKART}" = "YES" ] ;then
    zcat ${SB_PATCHDIR}/xfwm4-4.6.0-clearlooks.patch.gz | patch -p1 --verbose || exit 1
  fi
fi

if [ "${BASENAME}" = "libxfcegui4-${VERSION}" ]; then
  zcat ${SB_PATCHDIR}/libxfcegui4-4.4.2-xfce-exec-use-thunar.patch.gz | patch -p1 --verbose || exit 1
fi

if [ "${BASENAME}" = "libxfcegui4-${VERSION}" ]; then
  if [ "${SB_PA}" = "YES" ] ; then
    zcat ${SB_PATCHDIR}/xfce-utils-4.4.2-pulseaudio.patch.gz | patch -p1 --verbose || exit 1
  fi
fi

if [ "${BASENAME}" = "xfce4-panel-${VERSION}" ]; then
  zcat ${SB_PATCHDIR}/xfce4-panel-4.6.0-defaults.patch.gz | patch -p1 --verbose || exit 1
fi

if [ "${BASENAME}" = "xfce4-session-${VERSION}" ]; then
  zcat ${SB_PATCHDIR}/xfce4-session-4.5.92-hide-tips.patch.gz | patch -p1 --verbose || exit 1
fi

if [ "${BASENAME}" = "xfce4-utils-${VERSION}" ]; then
  if [ "${SB_PA}" = "YES" ] ; then
    zcat ${SB_PATCHDIR}/xfce-utils-4.5.91-startxfce-data-dirs.patch.gz | patch -p1 --verbose || exit 1
  fi
fi
