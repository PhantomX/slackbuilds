  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/net-snmp-5.4.1-pie.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/net-snmp-5.5-dir-fix.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/net-snmp-5.5-multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/net-snmp-5.5-sensors3.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/net-snmp-5.5-udptable-index.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/net-snmp-5.5-missing-bcast.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/net-snmp-5.5-tcp-pid.patch.gz | patch -p1 -E --backup --verbose || exit 1
