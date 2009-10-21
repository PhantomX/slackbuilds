
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/SDL-1.2.10-byteorder.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/SDL-1.2.12-multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/SDL-1.2.12-disable_yasm.patch.gz | patch -p1 -E --backup --verbose || exit 1

if [ "${SB_ALSA}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/SDL-1.2.14-audiodriver.patch.gz | patch -p1 -E --backup --verbose || exit 1
fi

# submitted upstream:
# submitted upstream:
# http://bugzilla.libsdl.org/show_bug.cgi?id=699
zcat ${SB_PATCHDIR}/SDL-1.2.13-rh484362.patch.gz | patch -p1 -E --backup --verbose || exit 1
