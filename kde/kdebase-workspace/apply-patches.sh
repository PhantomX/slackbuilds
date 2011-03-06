
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .startkde-slk --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.80-redhat_startkde.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.0-plasma-konsole.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.92-systemsettings_onlyshowin_kde.patch
# 441062: packagekit tools do not show icons correctly on KDE
zcat ${SB_PATCHDIR}/${NAME}-4.0.3-krdb.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.2.85-klipper-url.patch.gz | patch -p1 -E --backup --verbose
# 434824: KDE4 System Settings - No Method To Enter Administrative Mode
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.90-rootprivs.patch
zcat ${SB_PATCHDIR}/${NAME}-4.1.96-font.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.3.75-kio_sysinfo.patch.gz | patch -p1 -E --backup --verbose
# show the remaining time in the battery plasmoid's popup (as in 4.2) (#515166)
# currently requires backport from pre-4.3.80 trunk (Patch100)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.80-battery-plasmoid-showremainingtime.patch
# allow adding a "Leave..." button which brings up the complete shutdown dialog
# to the classic menu (as in KDE <= 4.2.x); the default is still the upstream
# default Leave submenu
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.80-classicmenu-logout.patch
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.92-kdm_plymouth.patch
# kubuntu kudos! bulletproof-X bits ripped out
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.92-kdm_plymouth081.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.92-xsession_errors_O_APPEND.patch
# support the widgetStyle4 hack in the Qt KDE platform plugin
zcat ${SB_PATCHDIR}/${NAME}-4.3.98-platformplugin-widgetstyle4.patch.gz | patch -p1 -E --backup --verbose
# fix the Games menu in the classic menu mixing up Name and Description
#zcat ${SB_PATCHDIR}/${NAME}-4.4.0-classicmenu-games.patch.gz | patch -p1 -E --backup --verbose
# drop hard dep on xorg-x11-apps (for xmessage), http://bugzilla.redhat.com/537609
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.2-startkde_zenity.patch 
# HALsectomy
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.85-no_HAL.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.90-no_HAL2.patch

# Mandriva
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.71-notify_color_changes.patch

# upstream patches:
# "keyboard stops working", https://bugs.kde.org/show_bug.cgi?id=171685#c135
zcat ${SB_PATCHDIR}/${NAME}-4.3.3-kde\#171685.patch.gz | patch -p1 -E --backup --verbose

# Branch patches

## trunk patches

set +e +o pipefail
