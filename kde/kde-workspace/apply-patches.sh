
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## Most patches are from Fedora
patch -p1 -E --backup -z .startkde-slk --verbose -i ${SB_PATCHDIR}/${NAME}-4.10.1-redhat_startkde.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.9.90-plasma_konsole.patch
# 441062: packagekit tools do not show icons correctly on KDE
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase-workspace-4.6.80-krdb.patch
zcat ${SB_PATCHDIR}/kdebase-workspace-4.2.85-klipper-url.patch.gz | patch -p1 -E --backup --verbose
# 434824: KDE4 System Settings - No Method To Enter Administrative Mode
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase-workspace-4.4.90-rootprivs.patch
zcat ${SB_PATCHDIR}/kdebase-workspace-4.3.75-kio_sysinfo.patch.gz | patch -p1 -E --backup --verbose
# show the remaining time in the battery plasmoid's popup (as in 4.2) (#515166)
# currently requires backport from pre-4.3.80 trunk (Patch100)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kde-workspace-4.8.80-battery-plasmoid-showremainingtime.patch
# allow adding a "Leave..." button which brings up the complete shutdown dialog
# to the classic menu (as in KDE <= 4.2.x); the default is still the upstream
# default Leave submenu
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.80-classicmenu-logout.patch
# kubuntu kudos! bulletproof-X bits ripped out
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase-workspace-4.4.92-kdm_plymouth081.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase-workspace-4.4.92-xsession_errors_O_APPEND.patch
# multilib QT_PLUGIN_PATH, http://bugzilla.redhat.com/704840
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase-workspace-4.6.90-multilib_qt_plugin_path.patch
# HALsectomy
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.80-no_HAL.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase-workspace-4.5.90-no_HAL2.patch

# plasmaclock displayEvents=false default, one more item to avoid
# starting akonadi by default
# FIXME/TODO: implement this via config to plasma javascript somehow?
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.2-displayEvents_default.patch

# Mandriva
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase-workspace-4.5.71-notify_color_changes.patch

# revert patch adding broken browser launcher
# https://projects.kde.org/projects/kde/kde-workspace/repository/revisions/2bbbbdd8fe5a38ae27bab44c9515b2ba78f75277
# https://bugzilla.redhat.com/show_bug.cgi?id=747982
# https://bugs.kde.org/show_bug.cgi?id=284628
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase-workspace-4.7.2-bz\#747982-launchers.patch

# add ktp_presence applet to default systray
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.8.0-systray_ktp_presence.patch

# upstreamable patches:
# "keyboard stops working", https://bugs.kde.org/show_bug.cgi?id=171685#c135
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.80-kde\#171685.patch

# use /etc/login.defs to define a 'system' account instead of hard-coding 500 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.8.2-bz\#732830-login.patch

# kdm overwrites ~/.Xauthority with wrong SELinux context on logout
# http://bugzilla.redhat.com/567914
# http://bugs.kde.org/242065
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.95-kdm_xauth.patch

if [ "${SB_SYSTEMD}" = "YES" ] ;then
  # pam/systemd bogosity: kdm restart/shutdown does not work 
  # http://bugzilla.redhat.com/796969
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.8.0-bug796969.patch
  # merged patches: systemd-switch-user{,2} systemd-shutdown
  # Support for systemd AND ConsoleKit in kworkspace
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.9.3-systemd-displaymanager.patch
fi

## upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/changeset_rc6ccec336987780358d316351cab4b6b77c506e2.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/changeset_r15b5220cefc53321a3f82035ecc1399761595ed7.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/changeset_r82ee44dd5adfef655a685d657fcc8b518ce3f590.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/changeset_r20239fd28c5929a5b2f211666a7b2b93ff9e1133.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/changeset_rf40d7a41e78bf229e2a7fa7d921e77157dc01ac8.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/changeset_r569f79c60f8fd2b3e655433c2c53f840b4c103e9.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/changeset_r4803296de2a11a1712e1c3cb77500ffc261c3945.diff

## plasma active patches

## trunk patches

# Arch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/terminate-server.patch

set +e +o pipefail
