  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/alsa-lib-1.0.17-config.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/alsa-lib-1.0.14-glibc-open.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/alsa-lib-1.0.16-no-dox-date.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/alsa-lib-1.0.22-closetimer.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/alsa-lib-1.0.22-softvol.patch.gz | patch -p1 -E --backup --verbose || exit 1
