  
SB_PATCHDIR=${CWD}/patches

if [ "${SB_PA}" = "YES" ] ;then
  # bump PulseAudio's priority in the xine backend
  zcat ${SB_PATCHDIR}/${NAME}-4.3.50-xine_pulseaudio.patch.gz | patch -p1 -E --backup --verbose || exit 1
fi
