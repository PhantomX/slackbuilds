
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-4.1.x-searchproviders-shortcuts.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.2.85-knetattach.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.1.1-iconthemes-inherit.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.3.1-manpath.patch.gz | patch -p1 -E --backup --verbose
# add OnlyShowIn=KDE  to Desktop/Home.desktop (like trash.desktop)
zcat ${SB_PATCHDIR}/${NAME}-4.3.3-home_onlyshowin_kde.patch.gz | patch -p1 -E --backup --verbose

# Mandriva
zcat ${SB_PATCHDIR}/${NAME}-4.3.2-knotify-fix-cpu-charge.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-nepomuk-strigi-smartfile.patch

# Branch patches

# Trunk  patches

## Branch upstream patches
# backport of 1160390, fixed: start call to cagibi only in next event loop, could be started
# in on-demand load by a d-bus call ourself, so d-bus connection has a mutex locked already
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.0-kioslave.patch

set +e +o pipefail
