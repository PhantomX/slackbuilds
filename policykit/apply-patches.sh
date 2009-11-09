  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/pk-ck-api-change.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/entry-leak.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/PolicyKit-src_kit_kit-string.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/polkit-0.8-dbus-policy.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/policykit-0.9-admingroup.patch.gz | patch -p1 -E --backup --verbose || exit 1
