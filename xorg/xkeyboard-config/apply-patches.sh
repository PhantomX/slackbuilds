  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/olpc-xkeyboard-config-kz-group.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/usinet.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Sent to svn, not committed yet (he's waiting for libX11 release)
zcat ${SB_PATCHDIR}/${NAME}-1.4-battery.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Sent to svu
zcat ${SB_PATCHDIR}/${NAME}-1.4-jp-tilde.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.5-evdevkbds.patch.gz | patch -p1 -E --backup --verbose || exit 1

# From debian
zcat ${SB_PATCHDIR}/mac_poweroff.diff.gz | patch -p1 -E --backup --verbose || exit 1
