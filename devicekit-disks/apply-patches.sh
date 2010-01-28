  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/devicekit-disks.atasmart.api.diff.gz| patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/avoid-ata-smart-check-for-removable-disks.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/devkit-disks-004-ignore-pc-floppy-drives.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/devkit-disks-004-parse-audio.patch.gz | patch -p1 -E --backup --verbose || exit 1
