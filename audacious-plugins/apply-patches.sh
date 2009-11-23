  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.0.1-xmms-skindir.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.1-alsa-ng.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.1-underruns.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.1-pulseaudio-volume.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.1-pulseaudio-volume-accuracy.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.1-modplug.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.1-sndfile-playfix.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.1-filewriter-dialogs.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.1-playlist-scrollbar.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/audacious_20090702_console.diff.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.1-ladspa-backto201.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.1-musepack.patch.gz | patch -p1 -E --backup --verbose || exit 1
# merged upstream
zcat ${SB_PATCHDIR}/${NAME}-2.1-sndstretch-dialog.patch.gz | patch -p1 -E --backup --verbose || exit 1
# merged upstream: dialog fix
# not necessary in 2.2-beta2?: crash work-around
zcat ${SB_PATCHDIR}/${NAME}-2.1-icecast.patch.gz | patch -p1 -E --backup --verbose || exit 1
