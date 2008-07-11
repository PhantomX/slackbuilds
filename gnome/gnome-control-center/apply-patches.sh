
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/control-center-2.20.0-enable-sound-by-default.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/control-center-2.19.3-no-gnome-common.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=497807
zcat ${SB_PATCHDIR}/background-location.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Fix some useless warnings in libslab
# http://bugzilla.gnome.org/show_bug.cgi?id=439398
( cd libslab
  zcat ${SB_PATCHDIR}/${NAME}-2.19.90-no-warnings.patch.gz | patch -p0 -E --backup --verbose || exit 1
) || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=524813
zcat ${SB_PATCHDIR}/${NAME}-2.22.0-caps-lock-bindables.patch.gz | patch -p0 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=526944 
zcat ${SB_PATCHDIR}/no-gdmsetup.patch.gz | patch -p1 -E --backup --verbose || exit 1

# call the Fedora/RHEL graphical passwd changing apps
# zcat ${SB_PATCHDIR}/control-center-2.21.92-passwd.patch.gz | patch -p1 -E --backup --verbose || exit 1
# zcat ${SB_PATCHDIR}/control-center-2.21.92-gecos.patch.gz | patch -p1 -E --backup --verbose || exit 1
# change default preferred apps to programs we ship
zcat ${SB_PATCHDIR}/default-applications.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/add-randr12-capplet.patch.gz | patch -p1 -E --backup --verbose || exit 1
