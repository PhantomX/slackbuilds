
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/control-center-2.19.3-no-gnome-common.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/make-default.patch.gz | patch -p1 -E --backup --verbose || exit 1
# minor build breakage in gtk, will be fixed in the next gtk release
zcat ${SB_PATCHDIR}/gtkmarshal.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=545075 
zcat ${SB_PATCHDIR}/slab-icon-names.patch.gz | patch -p0 -E --backup --verbose || exit 1

# call the Fedora/RHEL graphical passwd changing apps
# zcat ${SB_PATCHDIR}/control-center-2.23.2-passwd.patch.gz | patch -p1 -E --backup --verbose || exit 1
# zcat ${SB_PATCHDIR}/control-center-2.23.2-gecos.patch.gz | patch -p1 -E --backup --verbose || exit 1
# change default preferred apps to programs we ship
zcat ${SB_PATCHDIR}/default-applications.patch.gz | patch -p1 -E --backup --verbose || exit 1
