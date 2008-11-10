  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${BNAME}-1.0.18-rpath.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${BNAME}-1.0.19-glibc-2.7.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${BNAME}-1.0.19-policykit.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${BNAME}-1.0.19-uninitialized.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/06_sanei_scsi_attach_fix.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/10_sm3840_unbreak_sane_open.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/22_dll_backend_conf.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/32_net_backend_standard_fix.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/33_scanimage_options_fix.patch.gz | patch -p1 -E --backup --verbose || exit 1
