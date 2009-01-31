  
SB_PATCHDIR=${CWD}/patches

# don't use -b on mkspec files, else they get installed too.
zcat ${SB_PATCHDIR}/${PNAME}-x11-opensource-src-4.2.2-multilib-optflags.patch.gz | patch -p1 -E --verbose || exit 1

if [ "${_qt4_datadir}" != "${_qt4_prefix}" ] ;then
  zcat ${SB_PATCHDIR}/${PNAME}-x11-opensource-src-4.2.2-multilib-QMAKEPATH.patch.gz | patch -p1 -E --verbose || exit 1
fi

zcat ${SB_PATCHDIR}/${PNAME}-all-opensource-src-4.4.0-rc1-as_IN-437440.patch.gz | patch -p1 -E --verbose || exit 1

# under GNOME, default to QGtkStyle if available
# (otherwise fall back to QCleanlooksStyle)
zcat ${SB_PATCHDIR}/${PNAME}-x11-opensource-src-4.4.0-qgtkstyle.patch.gz | patch -p1 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-x11-opensource-src-4.4.3-im.patch.gz | patch -p1 -E --verbose || exit 1

# qt-copy patches
echo "0242" >> patches/DISABLED
echo "0250" >> patches/DISABLED
echo "0251" >> patches/DISABLED
test -x apply_patches && ./apply_patches
