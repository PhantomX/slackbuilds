
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

# call the Fedora/RHEL graphical passwd changing apps
# zcat ${SB_PATCHDIR}/control-center-2.25.2-passwd.patch.gz | patch -p1 -E --backup --verbose || exit 1
# zcat ${SB_PATCHDIR}/control-center-2.25.2-gecos.patch.gz | patch -p1 -E --backup --verbose || exit 1
# change default preferred apps to programs we ship
zcat ${SB_PATCHDIR}/default-applications.patch.gz | patch -p1 -E --backup --verbose || exit 1

# update the shell common tasks to desktop files we ship
zcat ${SB_PATCHDIR}/shell-common-tasks.patch.gz | patch -p1 -E --backup --verbose || exit 1
