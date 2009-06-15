  
SB_PATCHDIR=${CWD}/patches

# build only the xine backend
zcat ${SB_PATCHDIR}/${NAME}-4.3.1-xineonly.patch.gz | patch -p1 -E --backup --verbose || exit 1

if [ "${SB_PA}" = "YES" ] ;then
  # bump PulseAudio's priority in the xine backend
  zcat ${SB_PATCHDIR}/${NAME}-4.2.96-xine-pulseaudio.patch.gz | patch -p1 -E --backup --verbose || exit 1
fi

## Upstream patches
# fix for non-ascii filenames in xine backend
zcat ${SB_PATCHDIR}/${NAME}-4.3.2-kdebug\#172242.patch.gz | patch -p1 -E --backup --verbose || exit 1
