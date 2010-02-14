  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${PNAME}-2.18.0.1-reload.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=568845
zcat ${SB_PATCHDIR}/${PNAME}-gettext.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/no-access-crash.patch.gz | patch -p1 -E --backup --verbose || exit 1
# upstream fix
zcat ${SB_PATCHDIR}/0001-Make-the-defaults-mechanism-find-the-right-polkit-ac.patch.gz | patch -p1 -E --backup --verbose || exit 1
# https://bugzilla.gnome.org/show_bug.cgi?id=608705
zcat ${SB_PATCHDIR}/0001-gconfd-Remove-worse-than-useless-signal-handlers-for.patch.gz | patch -p1 -E --backup --verbose || exit 1
