  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/0001-don-t-claim-we-would-know-what-reallocated-event-cou.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-Seagate-s-ST9160821AS-drive-encodes-something-strang.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-use-only-uppermost-32-bits-for-reallocated-sectors-c.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-Get-rid-of-qurik-9_UNKNOWN-again.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-black-list-a-few-attributes-on-FUJITSU-MHY2120BH-008.patch.gz | patch -p1 -E --backup --verbose || exit 1
