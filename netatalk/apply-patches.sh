  
SB_PATCHDIR=${CWD}/patches

# Fixup some paths in etc2ps.sh
zcat ${SB_PATCHDIR}/netatalk.etc2ps.diff.gz | patch -p1 || exit 1

# Allow building without xfs quota support
zcat ${SB_PATCHDIR}/netatalk-2.0.4-without_xfs.diff.gz | patch -p1 || exit 1

# Disallow transmission of passwords via cleartext and with old version 1 of
# the Diffie-Hellman protocol
zcat ${SB_PATCHDIR}/netatalk-2.0.4-afpdconf.diff.gz | patch -p1 || exit 1

zcat ${SB_PATCHDIR}/netatalk-2.0.4-db4_2-db4_3.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/netatalk-2.0.2-uams_no_pie.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/netatalk-2.0.4-extern_ucreator.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/netatalk-2.0.4-open_call.patch.gz | patch -p1 -E --backup --verbose || exit 1
