  
SB_PATCHDIR=${CWD}/patches

# Restore Xorg's Zap'ing behavior by default and make it
# clearer to the user how to edit and/or get back old behavior
zcat ${SB_PATCHDIR}/10-keymap.fdi-restore_zap.diff.gz | patch -p1 || exit 1


# https://bugzilla.redhat.com/show_bug.cgi?id=488177
zcat ${SB_PATCHDIR}/hal-remove-dell-killswitch.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://lists.freedesktop.org/archives/hal/2009-March/013125.html
zcat ${SB_PATCHDIR}/hal-KVM-evdev.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugs.freedesktop.org/show_bug.cgi?id=22442
zcat ${SB_PATCHDIR}/hal-HDAPS-blacklist.patch.gz | patch -p1 -E --backup --verbose || exit 1

# https://bugzilla.redhat.com/show_bug.cgi?id=523914
zcat ${SB_PATCHDIR}/hal-xen-unignore-axes.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/hal-use-at-console.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/hal-fix-libusb-detection.patch.gz | patch -p1 -E --backup --verbose || exit 1
