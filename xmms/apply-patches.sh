  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}.gtk.doublesize.diff.gz | patch -p1 || exit 1
zcat ${SB_PATCHDIR}/${NAME}.wmxmms_vis_depth_workaround.diff.gz | patch -p0 || exit 1

# Set default output plugin to ALSA
zcat ${SB_PATCHDIR}/${NAME}-1.2.6-audio.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Use RTLD_LAZY, not RTLD_NOW
zcat ${SB_PATCHDIR}/${NAME}-1.2.6-lazy.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Don't link *everything* against alsa-lib
zcat ${SB_PATCHDIR}/${NAME}-1.2.11-alsalib.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Avoid multilib devel conflicts
zcat ${SB_PATCHDIR}/${NAME}-1.2.11-multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Fix for crossfade >= 0.3.14 to work properly
zcat ${SB_PATCHDIR}/${NAME}-1.2.11-is_quitting.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Randomize playlists better
zcat ${SB_PATCHDIR}/${NAME}-1.2.10-configfile-safe-write..patch.gz | patch -p1 -E --backup --verbose || exit 
zcat ${SB_PATCHDIR}/${NAME}-1.2.10-reposition.patch.gz | patch -p1 -E --backup --verbose || exit 
