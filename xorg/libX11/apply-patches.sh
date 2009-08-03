  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/libX11-dont-forward-keycode-0.patch.gz | patch -p1 -E --backup --verbose || exit 1
