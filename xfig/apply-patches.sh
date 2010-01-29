  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/xfig-3.2.5a-default-apps.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/xfig-3.2.5-fhs.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/xfig.3.2.5-modularX.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/xfig.3.2.5-Xaw3d.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/xfig-3.2.5-enable-Xaw3d.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/xfig-3.2.5-urwfonts.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/xfig-3.2.5-debian.patch.gz | patch -p1 -E --backup --verbose || exit 1
