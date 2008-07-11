
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.10.1-use-builtin-apm.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.17.1-cpufreq.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.15.1.1-dont-require-display.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=424639
zcat ${SB_PATCHDIR}/${NAME}-2.18.0-fix-find.patch.gz | patch -p1 -E --backup --verbose || exit 1
# http://bugzilla.gnome.org/show_bug.cgi?id=428072
zcat ${SB_PATCHDIR}/${NAME}-2.18.0-node-leak.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=478485 includes the above
zcat ${SB_PATCHDIR}/${NAME}-2.21.1-mixer-sync.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=488824
#zcat ${SB_PATCHDIR}/gweather-network.patch.gz | patch -p1 -E --backup --verbose || exit 1

# do the nullapplet dance for battstat
zcat ${SB_PATCHDIR}/${NAME}-null-battstat.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=382100
zcat ${SB_PATCHDIR}/vertical-invest.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=511446
zcat ${SB_PATCHDIR}/gweather-gnome-vfs.patch.gz | patch -p1 -E --backup --verbose || exit 1

# http://bugzilla.gnome.org/show_bug.cgi?id=517500
zcat ${SB_PATCHDIR}/keyboard-properties.patch.gz | patch -p1 -E --backup --verbose || exit 1
