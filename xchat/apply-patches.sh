
SB_PATCHDIR=${CWD}/patches

#zcat ${SB_PATCHDIR}/${NAME}-2.8.4-redhat-desktop.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.8.7-use-sysconf-to-detect-cpus.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.0.2-freenode.patch.gz | patch -p0 -E --backup --verbose || exit 1
# see #241923
zcat ${SB_PATCHDIR}/${NAME}-2.8.4-disable-tray-icon-by-default.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.8.4-shm-pixmaps.patch.gz | patch -p1 -E --backup --verbose || exit 1
