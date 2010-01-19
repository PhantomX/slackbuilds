  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-4.0.3-cfg.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.2.0-noexecstack.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/allegro-4.4.0-multilib.patch.gz | patch -p1 -E --backup --verbose -z .multilib || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.2.1-noexecmod.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/allegro-4.4.0-libdir.patch.gz | patch -p1 -E --backup --verbose -z .multilib2 || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.2.2-fullscreen-viewport.patch.gz | patch -p1 -E --backup --verbose || exit 1
