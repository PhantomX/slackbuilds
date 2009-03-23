
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.10.1-use-builtin-apm.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.15.1.1-dont-require-display.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=424639
zcat ${SB_PATCHDIR}/${NAME}-2.18.0-fix-find.patch.gz | patch -p1 -E --backup --verbose || exit 1

# do the nullapplet dance for battstat
zcat ${SB_PATCHDIR}/${NAME}-null-battstat.patch.gz | patch -p1 -E --backup --verbose || exit 1

if [ "${SB_MIXER}" != "YES" ] ;then
  # and keep the mixer hidden away from the add to panel dialog
  zcat ${SB_PATCHDIR}/gnome-applets-no-mixer-icon.patch.gz | patch -p1 -E --backup --verbose || exit 1
fi

# http://bugzilla.gnome.org/show_bug.cgi?id=575782
zcat ${SB_PATCHDIR}/mini-commander-https.patch.gz | patch -p1 -E --backup --verbose || exit 1
