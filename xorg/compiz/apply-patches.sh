  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/composite-cube-logo.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.8.2-wall.patchscale-key.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Make sure configuration plugins never get unloaded
zcat ${SB_PATCHDIR}/${NAME}-0.8.2-pin-initial-plugins.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Make the terminal keybinding work (RH #439665)
zcat ${SB_PATCHDIR}/${NAME}-0.8.2-gnome-terminal.patch.gz | patch -p1 -E --backup --verbose || exit 1

#Fix build
zcat ${SB_PATCHDIR}/${NAME}-0.8.2-gconf-buildfix.patch.gz | patch -p1 -E --backup --verbose || exit 1
