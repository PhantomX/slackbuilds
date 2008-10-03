  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/olpc-xkeyboard-config-kz-group.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/usinet.patch.gz | patch -p1 -E --backup --verbose || exit 1

# From debian
zcat ${SB_PATCHDIR}/001_keypad_comma.diff.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/add_void_definition_pl-324647.diff.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/mac_poweroff.diff.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sclk_toggle.diff.gz | patch -p1 -E --backup --verbose || exit 1
