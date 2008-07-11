
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/add-randr-12.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.21.91-ignore-model-if-evdev.patch.gz | patch -p1 -E --backup --verbose || exit 1
# https://bugzilla.redhat.com/show_bug.cgi?id=438942
# http://bugzilla.gnome.org/show_bug.cgi?id=524499
( cd plugins/mouse || exit 1
  zcat ${SB_PATCHDIR}/gsd-mouse-too-much-grab.patch.gz | patch -p0 -E --backup --verbose || exit 1
) || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.22.1-hide-white-screen.patch.gz | patch -p1 -E --backup --verbose || exit 1
