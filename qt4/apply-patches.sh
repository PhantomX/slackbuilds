  
SB_PATCHDIR=${CWD}/patches

# qt-copy patches
echo "0250" >> patches/DISABLED
test -x apply_patches && ./apply_patches

# don't use -b on mkspec files, else they get installed too.
zcat ${SB_PATCHDIR}/${PNAME}-x11-opensource-src-4.2.2-multilib-optflags.patch.gz | patch -p1 -E --verbose || exit 1

if [ "${_qt4_datadir}" != "${_qt4_prefix}" ] ;then
  zcat ${SB_PATCHDIR}/${PNAME}-x11-opensource-src-4.2.2-multilib-QMAKEPATH.patch.gz | patch -p1 -E --verbose || exit 1
fi

zcat ${SB_PATCHDIR}/${PNAME}-all-opensource-src-4.4.0-rc1-as_IN-437440.patch.gz | patch -p1 -E --verbose || exit 1

# hack around gcc/ppc crasher, http://bugzilla.redhat.com/492185
zcat ${SB_PATCHDIR}/${PNAME}-x11-opensource-src-4.5.0-gcc_hack.patch.gz | patch -p1 -E --verbose || exit 1
# qt fails to build on ia64: http://bugzilla.redhat.com/492174
zcat ${SB_PATCHDIR}/${PNAME}-x11-opensource-src-4.5.0-ia64_boilerplate.patch.gz | patch -p1 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-x11-opensource-src-4.5.1-enable_ft_lcdfilter.patch.gz | patch -p1 -E --verbose || exit 1

## upstreamable bits
# http://bugzilla.redhat.com/485677
zcat ${SB_PATCHDIR}/${PNAME}-x11-opensource-src-4.5.0-qdoc3.patch.gz | patch -p1 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/${PNAME}-4.5-sparc64.patch.gz | patch -p1 -E --verbose || exit 1
# fix invalid inline assembly in qatomic_{i386,x86_64}.h (de)ref implementations
# should fix the reference counting in qt_toX11Pixmap and thus the Kolourpaint
# crash with Qt 4.5
zcat ${SB_PATCHDIR}/${PNAME}-x11-opensource-src-4.5.0-fix-qatomic-inline-asm.patch.gz | patch -p1 -E --verbose || exit 1
