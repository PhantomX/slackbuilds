  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.6.2-aim-buddy-status-grab.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.6.2-yahoo-buddy-idle-time.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.6.2-yahoo-status-change-away.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.6.2-crash-validate-jid.patch.gz | patch -p0 -E --backup --verbose || exit 1
