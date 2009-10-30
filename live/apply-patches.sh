  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/live-2009.09.28-cflags.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/live-ip_mreq_source.diff.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/live-invalid_casts.diff.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/live-safe_setlocale.diff.gz | patch -p1 -E --backup --verbose || exit 1
