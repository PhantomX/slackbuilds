
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}.gtk.doublesize.diff.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}.wmxmms_vis_depth_workaround.diff.gz | patch -p0 -E --backup --verbose

# Set default output plugin to ALSA
zcat ${SB_PATCHDIR}/${NAME}-1.2.6-audio.patch.gz | patch -p1 -E --backup --verbose
# Use RTLD_LAZY, not RTLD_NOW
zcat ${SB_PATCHDIR}/${NAME}-1.2.6-lazy.patch.gz | patch -p1 -E --backup --verbose
# Don't link *everything* against alsa-lib
zcat ${SB_PATCHDIR}/${NAME}-1.2.11-alsalib.patch.gz | patch -p1 -E --backup --verbose
# Avoid multilib devel conflicts
zcat ${SB_PATCHDIR}/${NAME}-1.2.11-multilib-slk.patch.gz | patch -p1 -E --backup --verbose
# Fix for crossfade >= 0.3.14 to work properly
zcat ${SB_PATCHDIR}/${NAME}-1.2.11-is_quitting.patch.gz | patch -p1 -E --backup --verbose
# Randomize playlists better
zcat ${SB_PATCHDIR}/${NAME}-1.2.10-configfile-safe-write.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-1.2.10-reposition.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.2.11-dso.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xmms-1.2.10-ubuntu-CVE-2007-0653.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xmms-alsa-fix-loop.patch

set +e +o pipefail
