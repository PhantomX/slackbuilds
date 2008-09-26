
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.21.91-ignore-model-if-evdev.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.23.4-drop-sample-cache.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.23.91-fnf7-cycle.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=552857
zcat ${SB_PATCHDIR}/${NAME}-2.23.92-fade.patch.gz | patch -p1 -E --backup --verbose || exit 1
