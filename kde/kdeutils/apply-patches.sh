  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/klaptopdaemon-3.5-checksum.diff.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/superkaramba-3.5.7-network_sensor.patch.gz | patch -p2 --verbose || exit 1
zcat ${SB_PATCHDIR}/kdf-3.0.2-label.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.5.4-bz\#205553.patch.gz | patch -p1 --verbose || exit 1

# KDEmod patches
zcat ${SB_PATCHDIR}/04_xmms-dynamic.patch.gz | patch -p1 --verbose || exit 1
