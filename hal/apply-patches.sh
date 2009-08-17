  
SB_PATCHDIR=${CWD}/patches

# https://bugzilla.redhat.com/show_bug.cgi?id=488177
zcat ${SB_PATCHDIR}/hal-remove-dell-killswitch.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/hal-tablet-evdev.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://lists.freedesktop.org/archives/hal/2009-March/013125.html
zcat ${SB_PATCHDIR}/hal-KVM-evdev.patch.gz | patch -p1 -E --backup --verbose || exit 1
