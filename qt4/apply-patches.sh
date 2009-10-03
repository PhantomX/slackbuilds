  
SB_PATCHDIR=${CWD}/patches

# don't use -b on mkspec files, else they get installed too.
zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.2.2-multilib-optflags.patch.gz | patch -p1 -E --verbose || exit 1

if [ "${_qt4_datadir}" != "${_qt4_prefix}" ] ;then
  zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.2.2-multilib-QMAKEPATH.patch.gz | patch -p1 -E --verbose || exit 1
fi

zcat ${SB_PATCHDIR}/qt-all-opensource-src-4.4.0-rc1-as_IN-437440.patch.gz | patch -p1 -E --verbose || exit 1

# hack around gcc/ppc crasher, http://bugzilla.redhat.com/492185
zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.5.0-gcc_hack.patch.gz | patch -p1 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.5.1-enable_ft_lcdfilter.patch.gz | patch -p1 -E --verbose || exit 1
# include kde4 plugin path, http://bugzilla.redhat.com/498809
zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.5.1-kde4_plugins.patch.gz | patch -p1 -E --verbose || exit 1

# make PulseAudio the default device in Phonon with the xine-lib backend
# (The GStreamer backend handles this entirely differently, with a separate
# "sink" setting, and should pick up the PulseAudio "sink" without patches.)
if [ "${SB_PA}" = "YES" ] ;then
  zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.5.2-pulseaudio.patch.gz | patch -p1 -E --verbose || exit 1
  zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.5.2-gst-pulsaudio.patch.gz | patch -p1 -E --verbose || exit 1
fi

zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.5.1-phonon.patch.gz | patch -p1 -E --verbose || exit 1

# use system ca-bundle certs, http://bugzilla.redhat.com/521911
zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.5.3-system_ca_certificates.patch.gz | patch -p1 -E --verbose || exit 1


## upstreamable bits
# http://bugzilla.redhat.com/485677
zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.5.0-qdoc3.patch.gz | patch -p1 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/qt-4.5-sparc64.patch.gz | patch -p1 -E --verbose || exit 1
# fix invalid inline assembly in qatomic_{i386,x86_64}.h (de)ref implementations
# should fix the reference counting in qt_toX11Pixmap and thus the Kolourpaint
# crash with Qt 4.5
zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.5.0-fix-qatomic-inline-asm.patch.gz | patch -p1 -E --verbose || exit 1
# fix invalid assumptions about mysql_config --libs
# http://bugzilla.redhat.com/440673
zcat ${SB_PATCHDIR}/qt-x11-opensource-src-4.5.1-mysql_config.patch.gz | patch -p1 -E --verbose || exit 1

# security patches

# kde-qt git patches
zcat ${SB_PATCHDIR}/0001-This-patch-uses-object-name-as-a-fallback-for-window.patch.gz | patch -p1 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/0002-This-patch-makes-override-redirect-windows-popup-me.patch.gz | patch -p1 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/0003-This-patch-changes-QObjectPrivateVersion-thus-preve.patch.gz | patch -p1 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/0004-This-patch-adds-support-for-using-isystem-to-allow.patch.gz | patch -p1 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/0005-When-tabs-are-inserted-or-removed-in-a-QTabBar.patch.gz | patch -p1 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/0006-Fix-configure.exe-to-do-an-out-of-source-build-on-wi.patch.gz | patch -p1 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/0007-When-using-qmake-outside-qt-src-tree-it-sometimes-g.patch.gz | patch -p1 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/0008-In-a-treeview-with-columns-like-this.patch.gz | patch -p1 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/0009-This-patch-fixes-deserialization-of-values-with-cust.patch.gz | patch -p1 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/0010-Import-README.qt-copy-from-the-original-qt-copy.patch.gz | patch -p1 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/0011-Update-this-file-to-reflect-the-workflow-with-Git-a.patch.gz | patch -p1 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/0274-shm-native-image-fix.patch
zcat ${SB_PATCHDIR}/0015-Make-QMenu-respect-the-minimum-width-set.patch.gz | patch -p1 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/0016-Fill-gap-of-X.org-XFree-multimedia-special-launcher.patch.gz | patch -p1 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/0017-Add-context-to-tr-calls-in-QShortcut.patch.gz | patch -p1 -E --verbose || exit 1

# these patches are not merged yet in kde-qt branches
zcat ${SB_PATCHDIR}/0118-qtcopy-define.diff.gz | patch -p0 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/0283-do-not-deduce-scrollbar-extent-twice.diff.gz | patch -p0 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/0285-qgv-dontshowchildren.diff.gz | patch -p0 -E --verbose || exit 1
