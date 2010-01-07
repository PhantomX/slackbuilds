  
SB_PATCHDIR=${CWD}/patches

# From upstream
zcat ${SB_PATCHDIR}/libXext-1.1-event_vec-smash.patch.gz | patch -p1 -E --backup --verbose || exit 1
