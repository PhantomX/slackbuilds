
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/control-center-2.19.3-no-gnome-common.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/make-default.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=545075 
zcat ${SB_PATCHDIR}/slab-icon-names.patch.gz | patch -p0 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=555591
zcat ${SB_PATCHDIR}/default-layout-toggle.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=588729
zcat ${SB_PATCHDIR}/mnemonic.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://mail.gnome.org/archives/gnomecc-list/2009-July/msg00015.html
zcat ${SB_PATCHDIR}/no-tweaks.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=590349
zcat ${SB_PATCHDIR}/save-as.patch.gz | patch -p1 -E --backup --verbose || exit 1

# https://bugzilla.gnome.org/show_bug.cgi?id=596369
zcat ${SB_PATCHDIR}/fix-background-tooltips.patch.gz | patch -p1 -E --backup --verbose || exit 1

# https://bugzilla.gnome.org/show_bug.cgi?id=593866
zcat ${SB_PATCHDIR}/mirror-crash.patch.gz | patch -p1 -E --backup --verbose || exit 1

# https://bugzilla.gnome.org/show_bug.cgi?id=597066
zcat ${SB_PATCHDIR}/shell-markup.patch.gz | patch -p1 -E --backup --verbose || exit 1

# https://bugzilla.gnome.org/show_bug.cgi?id=596939
zcat ${SB_PATCHDIR}/keybinding-bugs.patch.gz | patch -p1 -E --backup --verbose || exit 1

# https://bugzilla.gnome.org/show_bug.cgi?id=592348
zcat ${SB_PATCHDIR}/about-me-delete.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/finger-icons.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/best-shapes.patch.gz | patch -p1 -E --backup --verbose || exit 1

# https://bugzilla.gnome.org/show_bug.cgi?id=147808
zcat ${SB_PATCHDIR}/monitor-aspect.patch.gz | patch -p1 -E --backup --verbose || exit 1

# https://bugzilla.gnome.org/show_bug.cgi?id=492974
zcat ${SB_PATCHDIR}/override-redirect.patch.gz | patch -p1 -E --backup --verbose || exit 1

# https://bugzilla.gnome.org/show_bug.cgi?id=604130
Patch62: no-duplicate-keybindings-dammit.patch.gz | patch -p1 -E --backup --verbose || exit 1
# https://bugzilla.gnome.org/show_bug.cgi?id=604295
zcat ${SB_PATCHDIR}/and-no-wrong-keybindings-either.patch.gz | patch -p1 -E --backup --verbose || exit 1

# https://bugzilla.redhat.com/show_bug.cgi?id=522195
# https://bugzilla.gnome.org/show_bug.cgi?id=606155
zcat ${SB_PATCHDIR}/close-fd-leak.patch.gz | patch -p1 -E --backup --verbose || exit 1

# call the Fedora/RHEL graphical passwd changing apps
# zcat ${SB_PATCHDIR}/control-center-2.25.2-passwd.patch.gz | patch -p1 -E --backup --verbose || exit 1
# zcat ${SB_PATCHDIR}/control-center-2.25.2-gecos.patch.gz | patch -p1 -E --backup --verbose || exit 1
# change default preferred apps to programs we ship
zcat ${SB_PATCHDIR}/default-applications.patch.gz | patch -p1 -E --backup --verbose || exit 1

# update the shell common tasks to desktop files we ship
zcat ${SB_PATCHDIR}/shell-common-tasks.patch.gz | patch -p1 -E --backup --verbose || exit 1

# disable touchpad GUI parts if the touchpad can't do two-finger/tapping
# Includes https://bugzilla.gnome.org/show_bug.cgi?id=606793
zcat ${SB_PATCHDIR}/disable-touchpad-on-capabilities.patch.gz | patch -p1 -E --backup --verbose || exit 1
