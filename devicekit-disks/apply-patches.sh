  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/0001-Update-udev-rules-to-cope-better-with-device-mapper.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-Bug-24885-LVM-LVs-now-have-NOPOLICY-0.patch.gz | patch -p1 -E --backup --verbose || exit 1
