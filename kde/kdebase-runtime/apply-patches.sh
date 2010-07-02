
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
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-nepomuk-strigi-smartfile.patch
zcat ${SB_PATCHDIR}/${NAME}-4.3.2-knotify-fix-cpu-charge.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-nepomuk-sync-with-trunk.patch

# Branch patches

# Trunk  patches
zcat ${SB_PATCHDIR}/${NAME}-4.3.98-t1079784-add-kupnp-support.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.3.98-t1079789-fix-kdebug.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.3.98-t1079790-fix-libs.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.3.98-t1079845-disable-kioslave.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.3.98-t1079847-remove-upnp.cmake.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.3.98-t1079848-fix-build.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.3.98-t1079849-activate-shared-lib.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.2-t1107759-fix-reload-model.patch 

## 4.4 Upstream patches
zcat ${SB_PATCHDIR}/kdebase-runtime-4.4.0-virtuosoconverter.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
