
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/oyranos-0.1.9-sw_elektra.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/oyranos-0.1.9-shared_NVCtrl.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/oyranos-0.1.9-default.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/oyranos-0.1.9-man-1_3.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/oyranos-0.1.9-rm_class.patch.gz | patch -p1 -E --backup --verbose || exit 1
