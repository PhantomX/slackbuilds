
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-4.4.0-startkde.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.3.98-plasma-konsole.patch
zcat ${SB_PATCHDIR}/${NAME}-4.3.75-show_systemsettings.patch.gz | patch -p1 -E --backup --verbose
# For ck 0.3.1
#zcat ${SB_PATCHDIR}/${NAME}-4.2.85-ck-shutdown.patch.gz | patch -p1 -E --backup --verbose
# For ck 0.4.1
zcat ${SB_PATCHDIR}/${NAME}-4.3.95-ck-shutdown.patch.gz | patch -p1 -E --backup --verbose
# 441062: packagekit tools do not show icons correctly on KDE
zcat ${SB_PATCHDIR}/${NAME}-4.0.3-krdb.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.2.85-klipper-url.patch.gz | patch -p1 -E --backup --verbose
# 434824: KDE4 System Settings - No Method To Enter Administrative Mode
zcat ${SB_PATCHDIR}/${NAME}-4.3.75-rootprivs.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.1.96-font.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.2.0-pykde4.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.3.75-kio_sysinfo.patch.gz | patch -p1 -E --backup --verbose
# show the remaining time in the battery plasmoid's popup (as in 4.2) (#515166)
# currently requires backport from pre-4.3.80 trunk (Patch100)
zcat ${SB_PATCHDIR}/${NAME}-4.3.98-battery-plasmoid-showremainingtime.patch.gz | patch -p1 -E --backup --verbose
# allow adding a "Leave..." button which brings up the complete shutdown dialog
# to the classic menu (as in KDE <= 4.2.x); the default is still the upstream
# default Leave submenu
zcat ${SB_PATCHDIR}/${NAME}-4.4.0-classicmenu-logout.patch.gz | patch -p1 -E --backup --verbose
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.2-kdm_plymouth.patch
# kubuntu kudos! bulletproof-X bits ripped out
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.2-kdm_plymouth081.patch

zcat ${SB_PATCHDIR}/${NAME}-4.3.80-xsession_errors_O_APPEND.patch.gz | patch -p1 -E --backup --verbose
# support the widgetStyle4 hack in the Qt KDE platform plugin
zcat ${SB_PATCHDIR}/${NAME}-4.3.98-platformplugin-widgetstyle4.patch.gz | patch -p1 -E --backup --verbose
# fix the Games menu in the classic menu mixing up Name and Description
zcat ${SB_PATCHDIR}/${NAME}-4.4.0-classicmenu-games.patch.gz | patch -p1 -E --backup --verbose

# Mandriva
#patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.3-b1122355-plasma-netbook-fix-icon.patch 
zcat ${SB_PATCHDIR}/${NAME}-4.1.1-save_color_scheme_name.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.1.2-notify_color_changes.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.3.98-lowdiskspace.patch.gz | patch -p0 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.1-battery-always-show-percent-left.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.2-trash-applet-add-confirmation.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.3-add-tooltip-simpleapplet.patch 
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.0-fix-lock-out.patch

# upstream patches:
# "keyboard stops working", https://bugs.kde.org/show_bug.cgi?id=171685#c135
zcat ${SB_PATCHDIR}/${NAME}-4.3.3-kde\#171685.patch.gz | patch -p1 -E --backup --verbose
# kubuntu working to upstream this
# FIXME: Not upstreamed yet --Ben (4.3.80)
#Patch51: http://bazaar.launchpad.net/~kubuntu-members/kdebase-workspace/ubuntu/annotate/head%3A/debian/patches/kubuntu_101_brightness_fn_keys_and_osd.diff
zcat ${SB_PATCHDIR}/${NAME}-4.3.95-brightness_keys.patch.gz | patch -p1 -E --backup --verbose

# 4.4 patches

set +e +o pipefail
