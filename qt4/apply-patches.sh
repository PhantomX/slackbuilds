  
SB_PATCHDIR=${CWD}/patches

# fix the qt-copy patch 0274-shm-native-image-fix.diff to apply against 4.5.2
zcat ${SB_PATCHDIR}/qt-copy-20090626-qt452.patch.gz | patch -p1 -E --verbose || exit 1

# qt-copy patches
echo "0234" >> patches/DISABLED
echo "0250" >> patches/DISABLED
echo "0273" >> patches/DISABLED
echo "0279" >> patches/DISABLED
echo "0281" >> patches/DISABLED
echo "0282" >> patches/DISABLED
test -x apply_patches && ./apply_patches

# don't use -b on mkspec files, else they get installed too.
zcat ${SB_PATCHDIR}/${PNAME}-x11-opensource-src-4.2.2-multilib-optflags.patch.gz | patch -p1 -E --verbose || exit 1

if [ "${_qt4_datadir}" != "${_qt4_prefix}" ] ;then
  zcat ${SB_PATCHDIR}/${PNAME}-x11-opensource-src-4.2.2-multilib-QMAKEPATH.patch.gz | patch -p1 -E --verbose || exit 1
fi

zcat ${SB_PATCHDIR}/${PNAME}-all-opensource-src-4.4.0-rc1-as_IN-437440.patch.gz | patch -p1 -E --verbose || exit 1

# hack around gcc/ppc crasher, http://bugzilla.redhat.com/492185
zcat ${SB_PATCHDIR}/${PNAME}-x11-opensource-src-4.5.0-gcc_hack.patch.gz | patch -p1 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-x11-opensource-src-4.5.1-enable_ft_lcdfilter.patch.gz | patch -p1 -E --verbose || exit 1
# include kde4 plugin path, http://bugzilla.redhat.com/498809
zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.5.1-kde4_plugins.patch.gz | patch -p1 -E --verbose || exit 1

# make PulseAudio the default device in Phonon with the xine-lib backend
# (The GStreamer backend handles this entirely differently, with a separate
# "sink" setting, and should pick up the PulseAudio "sink" without patches.)
if [ "${SB_PA}" = "YES" ] ;then
  ( cd src/3rdparty/phonon || exit 1
    zcat ${SB_PATCHDIR}/phonon-4.2.96-pulseaudio.patch.gz | patch -p1 -E --verbose || exit 1
  ) || exit 1
fi

zcat ${SB_PATCHDIR}/${PNAME}-x11-opensource-src-4.5.1-phonon.patch.gz | patch -p1 -E --verbose || exit 1

## upstreamable bits
# http://bugzilla.redhat.com/485677
zcat ${SB_PATCHDIR}/${PNAME}-x11-opensource-src-4.5.0-qdoc3.patch.gz | patch -p1 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-4.5-sparc64.patch.gz | patch -p1 -E --verbose || exit 1
# fix invalid inline assembly in qatomic_{i386,x86_64}.h (de)ref implementations
# should fix the reference counting in qt_toX11Pixmap and thus the Kolourpaint
# crash with Qt 4.5
zcat ${SB_PATCHDIR}/${PNAME}-x11-opensource-src-4.5.0-fix-qatomic-inline-asm.patch.gz | patch -p1 -E --verbose || exit 1
# fix invalid assumptions about mysql_config --libs
# http://bugzilla.redhat.com/440673
zcat ${SB_PATCHDIR}/${PNAME}-x11-opensource-src-4.5.1-mysql_config.patch.gz | patch -p1 -E --verbose || exit 1
