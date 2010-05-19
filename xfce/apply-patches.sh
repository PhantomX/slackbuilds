
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

if [ "${SPNAME}" = "exo" ]; then
  zcat ${SB_PATCHDIR}/exo-0.3.0-x86_64-build.patch.gz | patch -p1 --verbose
  # http://patches.ubuntu.com/e/exo/extracted/xubuntu-default-mount-options.patch
  zcat ${SB_PATCHDIR}/exo-0.3.105-default-mount-options.patch.gz | patch -p1 --verbose
  patch -p1 --verbose -i ${SB_PATCHDIR}/exo-fix-treeview-gtk2.20.patch
fi

if [ "${SPNAME}" = "Thunar" ]; then
  zcat ${SB_PATCHDIR}/thunar-libpng-1.4.patch.gz | patch -p1 --verbose
  zcat ${SB_PATCHDIR}/thunar-vfs-fix-umask.patch.gz | patch -p0 --verbose
  patch -p1 --verbose -i ${SB_PATCHDIR}/Thunar-1.0.1-dsofix.patch
fi

if [ "${SPNAME}" = "xfdesktop" ]; then
  echo
  if [ "${SB_SLKART}" = "YES" ] ;then
    zcat ${SB_PATCHDIR}/xfdesktop-4.5.92-backdrop-image.patch.gz | patch -p1 --verbose
  fi
  zcat ${SB_PATCHDIR}/xfdesktop-4.5.92-desktop-menu-icon.patch.gz | patch -p1 --verbose
  zcat ${SB_PATCHDIR}/xfdesktop-4.6.1-menu.patch.gz | patch -p1 --verbose
  # http://git.xfce.org/xfce/xfdesktop/commit/?id=c2de873891d8ce8c3be1399c6110ebfda489151b
  patch -p1 --verbose -i ${SB_PATCHDIR}/xfdesktop-4.6.1-education-menu-icon.patch
  # Upstream bug: http://bugzilla.xfce.org/show_bug.cgi?id=6235
  patch -p1 --verbose -i ${SB_PATCHDIR}/xfdesktop-4.6.1-dsofix.patch
  patch -p1 --verbose -i ${SB_PATCHDIR}/xfdesktop-4.6.1-assert.patch
fi

if [ "${SPNAME}" = "xfwm4" ]; then
  if [ "${SB_SLKART}" = "YES" ] ;then
    zcat ${SB_PATCHDIR}/xfwm4-4.6.0-clearlooks.patch.gz | patch -p1 --verbose
  fi
  zcat ${SB_PATCHDIR}/xfwm4-4.6.1-focus.patch.gz | patch -p1 --verbose
  patch -p1 --verbose -i ${SB_PATCHDIR}/xfwm4-4.6.1-multi-monitor.patch
  # Upstream bug: http://bugzilla.xfce.org/show_bug.cgi?id=6231
  patch -p1 --verbose -i ${SB_PATCHDIR}/xfwm4-4.6.1-dsofix.patch 
fi

if [ "${SPNAME}" = "libxfcegui4" ]; then
  zcat ${SB_PATCHDIR}/libxfcegui4-4.4.2-xfce-exec-use-thunar.patch.gz | patch -p1 --verbose
fi

if [ "${SPNAME}" = "xfce-utils" ]; then
  if [ "${SB_PA}" = "YES" ] ; then
    zcat ${SB_PATCHDIR}/xfce-utils-4.4.2-pulseaudio.patch.gz | patch -p1 --verbose
  fi
  zcat ${SB_PATCHDIR}/xfce-utils-4.4.3-xfterm4-bug.patch.gz | patch -p1 --verbose
  patch -p1 --verbose -i ${SB_PATCHDIR}/xfce-utils-4.6.1-startxfce-data-dirs.patch
  zcat ${SB_PATCHDIR}/xfce-utils-4.6.1-xdgconfig.patch.gz | patch -p1 --verbose
fi

if [ "${SPNAME}" = "xfce4-panel" ]; then
  zcat ${SB_PATCHDIR}/xfce4-panel-4.6.0-defaults.patch.gz | patch -p1 --verbose
  patch -p1 --verbose -i ${SB_PATCHDIR}/xfce4-panel-4.6.1-multilib.patch
  # Upstream bug: http://bugzilla.xfce.org/show_bug.cgi?id=6233
  patch -p1 --verbose -i ${SB_PATCHDIR}/xfce4-panel-4.6.3-dsofix.patch
fi

if [ "${SPNAME}" = "xfce4-session" ]; then
  zcat ${SB_PATCHDIR}/xfce4-session-4.5.92-hide-tips.patch.gz | patch -p1 --verbose
  # http://patches.ubuntu.com/x/xfce4-session/extracted/01_correct_shadows.patch
  zcat ${SB_PATCHDIR}/xfce4-session-4.6.1-correct-shadows.patch.gz | patch -p1 --verbose
fi

if [ "${SPNAME}" = "xfce4-settings" ]; then
  zcat ${SB_PATCHDIR}/xfce4-settings-4.6.4-libxklavier50.patch.gz | patch -p0 --verbose
  # Upstream bug: http://bugzilla.xfce.org/show_bug.cgi?id=6236
  patch -p1 --verbose -i ${SB_PATCHDIR}/xfce4-settings-4.6.4-dsofix.patch
fi

if [ "${SPNAME}" = "xfprint" ]; then
  # Upstream bug: http://bugzilla.xfce.org/show_bug.cgi?id=6237
  patch -p1 --verbose -i ${SB_PATCHDIR}/xfprint-4.6.0-dsofix.patch
fi
if [ "${SPNAME}" = "orage" ]; then
  # Upstream bug: http://bugzilla.xfce.org/show_bug.cgi?id=6237
  patch -p1 --verbose -i ${SB_PATCHDIR}/orage-4.6.1-dsofix.patch
fi

if [ "${SPNAME}" = "Terminal" ]; then
  # From Slackware
  patch -p1 --verbose -i ${SB_PATCHDIR}/terminal.gtk.2.18.fix.diff
fi

set +e +o pipefail
