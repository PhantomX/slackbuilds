  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/aspell-0.50.3-gcc33.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/aspell-0.60.3-install_info.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/aspell-0.60.5-fileconflict.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/aspell-0.60.5-pspell_conf.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/aspell-0.60.6-zero.patch.gz | patch -p1 -E --backup --verbose || exit 1
